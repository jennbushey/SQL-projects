"""
A program to generate service tickets.
Tickets generated populate the service_tickets SQL database. 
The program randomly generates values and randomly selects values from SQL 
tables in the database and populates them into the EVENTLOG table.
"""

import mysql.connector
import random
from random import randrange
import datetime
from datetime import timedelta

# MySQL database connection configuration.
config = {
    'user': 'username',
    'password': 'password',
    'host': '127.0.0.1',
    'database': 'service_tickets'
}

"""
Establish a global variable connection to the database.
Connection can be used in any function to query the database.
"""
try:
    connection = mysql.connector.connect(**config)
    if connection.is_connected():
        # Confirm connection to database
        print('Connected to MySQL database')
except mysql.connector.Error as err:
    print(f'Error: {err}')

try:
    cursor = connection.cursor()
except mysql.connector.Error as err:
    print(f'Error: {err}')


def get_primary_keys(table):
    """ Queries a MySQL database and returns the primary key values of that table. 
    Args: 
        query: a query statement looking for primary key in table. For example:
        "SELECT ID FROM EVENTACTIVITY"
    Returns:
        A tuple containing a list of the primary key values and table name.
    """
    # Query the database to fetch primary ID's
    query = "SELECT ID FROM {}".format(table)
    cursor.execute(query)
    # Fetch all the rows
    primary_ids = [row[0] for row in cursor.fetchall()]
    return (primary_ids, table)


def to_datetime(input):
    """Converts string date to date time value.
    Args:
        input: a string date formatted 'YYYY-MM-DD'
    Returns:
        A datetime object formatted '%Y-%m-%d'
    """
    format = '%Y-%m-%d'
    return datetime.datetime.strptime(input, format)


def random_date(start, end):
    """This function will return a random datetime between two datetime objects.

    Args: start: a datetime date.
          end: a datetime date sometime later than start.

    Returns: a datetime date at a random time between start and end.
    """
    delta = end - start
    int_delta = delta.days
    random = randrange(int_delta)
    return start + timedelta(random)


def random_value_query(primary_id):
    """ Takes list of primary keys from a two column table and returns the value
    found in the other column corresponding to the primary key. 
    Args: 
        primary_id: a tuple containing primary keys list and table name
    Returns:
        value corresponding to 
    """
    id, table = primary_id  # split tuple into id and table components
    id = random.choice(id)  # randomly select an id from the list

    # SQL query will return list of column names
    cursor.execute(f"DESCRIBE {table}")
    # grabs describe table and stores in column_info
    # allows for dynamic selection of column names
    column_info = cursor.fetchall()
    # SQL query constructed dynamically using results of previous query
    query = f"SELECT {column_info[1][0]} FROM {table} WHERE ID = {id}"
    cursor.execute(query)
    value = cursor.fetchall()
    return value[0][0]


def main():
    """
    Use SQL query to retrieve list of primary key for each supporting table.
    """
    eventActivityID = get_primary_keys("EVENTACTIVITY")
    eventStatusID = get_primary_keys("EVENTSTATUS")
    eventOriginID = get_primary_keys("EVENTORIGIN")
    eventClassID = get_primary_keys("EVENTCLASS")

    """
    User input
    Ask user for: number of tickets, start date, end date for ticket dates.
    Validate user date range and exit program if input is invalid.
    """

    num_Tickets = input("How many tickets would you like to generate? ")

    start_input = to_datetime(
        input("What is the start date for the tickets? YYYY-MM-DD "))
    end_input = to_datetime(
        input("What is the end date for the tickets? YYYY-MM-DD "))
    # Check for valid input.
    if (end_input < start_input):
        print("Invalid date range.")
        exit()

    """ 
    Event Log Value Generator:
    Generates random data for event log and runs SQL input query
    to populate the event log table.
    """
    # Create random unique caseID for each ticket
    caseID = random.sample(range(100000, 999999), int(num_Tickets))

    for i in range(int(num_Tickets)):
        # Generate random dates within user provided dates
        start_date = random_date(start_input, end_input)
        # Restricted end date to be 100 days after start date for dashboard visualization
        end_date = start_date + timedelta(random.randint(1, 100))

        # populate dictionary with
        # column names and values to be inserted in the database
        dict = {
            'caseID': "CS_{}".format(caseID[i]),
            'Activity': random_value_query(eventActivityID),
            'Urgency': random.choice(["1", "2", "3"]),
            'Impact': random.choice(["1", "2", "3"]),
            'StartDate': start_date.strftime('%Y-%m-%d'),
            'EndDate': end_date.strftime('%Y-%m-%d'),
            'TicketStatus': random_value_query(eventStatusID),
            'Origin': random_value_query(eventOriginID),
            'Class': random_value_query(eventClassID)
        }

        # Constructing the SQL INSERT query
        # source: https://stackoverflow.com/questions/9336270/using-a-python-dict-for-a-sql-insert-statement
        placeholder = ", ".join(["%s"] * len(dict))
        stmt = "INSERT INTO EVENTLOG ({columns}) values ({values});".format(
            columns=",".join(dict.keys()), values=placeholder)

        try:
            # insert statement
            cursor.execute(stmt, list(dict.values()))
            # update duration so that SQL calculates the duration of the ticket
            cursor.execute(
                "UPDATE EVENTLOG SET DURATION = (DATEDIFF(ENDDATE, STARTDATE)) WHERE ID > 0;")
            # need to commit changes to the database in order for them to persist
            connection.commit()
        except mysql.connector.Error as err:
            connection.rollback()
            # will notify of any errors in updating the database
            print(f'Error: {err}')

    # Close the cursor and connection
    cursor.close()
    connection.close()

    # Confirm SQL database has been updated.
    print('Database update complete.')


if __name__ == "__main__":
    main()
