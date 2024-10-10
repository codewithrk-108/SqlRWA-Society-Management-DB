from logging import root
import pymysql
import getpass
from prettytable import PrettyTable
from datetime import date

def insert(sql_cur,conn):
    print("\t\t\t Choose among them by typing index \t\t\t")
    print("\t\t\t\t1. Add a new resident in a flat \t\t\t")
    print("\t\t\t\t2. Adding new members to RWA \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head = []
    if(ch3i == 1):
        sql_cur.execute(
            "SELECT COLUMN_NAME,COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'residents'")
        for i in sql_cur:
            # for j in i:
                # if()
                inp = input("Enter " + i[0] + ": ")
                if(i[1]=="int"):
                    head.append(int(inp))
                else:
                    head.append(inp)
                # ct+=1
            # print(i)

        today_date = date.today()
        dob = head[4]
        age = ''
        age += dob[0] + dob[1] + dob[2] + dob[3]
        agemonth = ''
        agemonth += dob[5] + dob[6]
        agedate = ''
        agedate += dob[8] + dob[9]
        val = int(age)
        valmonth = int(agemonth)
        valday = int(agedate)
        tgempage = today_date.year - val - ((today_date.month, today_date.day) < (valmonth, valday))

        querytemp = "INSERT INTO age_from_dob (DOB,Age) VALUES (%s,%s)"
        sql_cur.execute(querytemp, (dob,tgempage));
        conn.commit()
        print("YESS!!!")
        sql_cur.execute("INSERT INTO residents VALUES('%d','%d','%s','%s','%s','%s','%s','%d')"%(head[0],head[1],head[2],head[3],head[4],head[5],head[6],head[7]))
        conn.commit()
        print("Successfully Inserted !")
    if(ch3i == 2):
        print("HELLO2")
        sql_cur.execute(
            "SELECT COLUMN_NAME,COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'rwa'")
        for i in sql_cur:
            # for j in i:
                # if()
                inp = input("Enter " + i[0] + ": ")
                if(i[1]=="int"):
                    head.append(int(inp))
                else:
                    head.append(inp)
                # ct+=1
            # print(i)
        # print(head)
        sql_cur.execute("INSERT INTO rwa VALUES('%d','%s','%s','%s','%s','%s')"%(head[0],head[1],head[2],head[3],head[4],head[5]))
        conn.commit()
        print("Successfully Inserted !")

def update(sql_cur,conn):
    print("\t\t\t\t1. Update Resolve Status of a Complaint \t\t\t")
    print("\t\t\t\t2. Update Responsibility of a member in RWA  \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head=[]
    if(ch3i == 1):
        com_id = int(input("Enter the Complaint_ID of the complaint to update: "))
        sql_cur.execute("UPDATE complaints SET Resolve_Status = '1' WHERE Complaint_ID = '%d' " %(com_id))
        conn.commit()
        print("SUCCESSFULLY Updated the status")
    if(ch3i == 2):
        phone_num = int(input("Enter the Phone Number of the Member of RWA whose responsibility has to be updated : "))
        updated_resp = input("Enter the responsibility to be updated to : ")
        sql_cur.execute("UPDATE rwa SET Responsibility = '%s' WHERE Phone_number = '%d' " %(updated_resp,phone_num))
        conn.commit()
        print("SUCCESSFULLY Updated Responsibilty")

def delete(sql_cur,conn):
    print("\t\t\t\t1. Delete visitor for a Particular Flat \t\t\t")
    print("\t\t\t\t2. Delete member From RWA \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head=[]
    if(ch3i == 1):
        phone_num = int(input("Enter the Phone Number of the visitor to delete: "))
        sql_cur.execute("DELETE FROM visitor WHERE Phone_number = '%d' " %(phone_num))
        conn.commit()
        print("SUCCESSFULLY DELETED VISITOR")
    if(ch3i == 2):
        phone_num = int(input("Enter the Phone Number of the member of RWA to delete: "))
        sql_cur.execute("DELETE FROM rwa WHERE Phone_number = '%d' " %(phone_num))
        conn.commit()
        print("SUCCESSFULLY DELETED MEMBER")


def Select(sql_cur):
    print("\t\t\t Choose among them by typing index \t\t\t")
    print("\t\t\t\t1. List of all Flats \t\t\t")
    print("\t\t\t\t2. List of all Residents \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head = []
    if(ch3i == 1):
        sql_cur.execute(
            "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'flats'")
        for i in sql_cur:
            for j in i:
                head.append(j)
            # print(i)
        sql_cur.execute("SELECT * FROM flats")
    if(ch3i == 2):
        sql_cur.execute(
            "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'residents'")
        for i in sql_cur:
            for j in i:
                head.append(j)
        sql_cur.execute("SELECT * FROM residents")
    x = PrettyTable()
    # print(head)
    x.field_names = head
    for i in sql_cur:
        x.add_row(i)
    print(x)


def Aggregate(sql_cur):
    print("\t\t\t Choose among them by typing index \t\t\t")
    print("\t\t\t\t1. Total Number of Residents in a house \t\t\t")
    print("\t\t\t\t2. Total number of requests of a particular flat \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head = []
    if(ch3i == 1):
        head.append("Flat_number")
        head.append("Total_Residents")
        sql_cur.execute(
            "SELECT Flat_number,COUNT(*) FROM residents GROUP BY Flat_number")
    if(ch3i == 2):
        head.append("Flat_number")
        head.append("Total_Requests")
        sql_cur.execute(
            "SELECT Flat_number,COUNT(*) FROM requests GROUP BY Flat_number")
    # store = sql_cur.fetchall()
    x = PrettyTable()
    # print(head)
    x.field_names = head
    for i in sql_cur:
        x.add_row(i)
    print(x)


def Project(sql_cur):
    print("\t\t\t Choose among them by typing index \t\t\t")
    print("\t\t\t\t1. Show visitors of a particular flat \t\t\t")
    print("\t\t\t\t2. Show complaints registered by a particular flat.\t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head = []
    if(ch3i == 1):
        head.append("First_name")
        head.append("Last_name")
        sql_cur.execute("Select Flat_number FROM flats")
        print("\t\t\tType_your_choice\t\t\t")
        for i in sql_cur:
            print("\t\t\t\t"+str(i[0]))
            # print(i)
        flat = input("Enter flat_number :")
        sql_cur.execute(
            "SELECT First_Name,Last_name FROM visitor WHERE Flat_number = '%s'" % (flat))
    if(ch3i == 2):
        sql_cur.execute("Select Flat_number FROM flats")
        print("\t\t\tType_your_choice\t\t\t")
        for i in sql_cur:
            print("\t\t\t\t"+str(i[0]))
        flat = input("Enter flat_number :")
        head.append("Complaint_ID")
        sql_cur.execute(
            "Select Complaint_Type FROM complaints WHERE Flat_number = 'A-101'")
    x = PrettyTable()
    # print(head)
    x.field_names = head
    for i in sql_cur:
        x.add_row(i)
    print(x)


def Search(sql_cur):
    print("\t\t\t Choose among them by typing index \t\t\t")
    print("\t\t\t\t1. Search Residents by Aadhar ID \t\t\t")
    print("\t\t\t\t2. Search Requests by Flat_Number \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    head = []
    if(ch3i == 1):
        head.append("First_name")
        head.append("Last_name")
        sql_cur.execute("Select Aadhar_number FROM residents")
        print("\t\t\tType_your_choice\t\t\t")
        for i in sql_cur:
            # print(i)
            print("\t\t\t\t"+str(i[0]))
        aadhar = int(input("Enter Aadhar_ID :"))
        sql_cur.execute(
            "Select First_name,Last_name FROM residents WHERE Aadhar_number = '%d'" % (aadhar))
    if(ch3i == 2):
        sql_cur.execute("Select Flat_number FROM flats")
        print("\t\t\tType_your_choice\t\t\t")
        for i in sql_cur:
            print("\t\t\t\t"+i[0])
        flat = input("Enter flat_number :")
        head.append("Request_Type")
        sql_cur.execute(
            "Select Request_Type FROM requests WHERE Flat_number = '%s'" % (flat))
    x = PrettyTable()
    x.field_names = head
    for i in sql_cur:
        x.add_row(i)
    print(x)


def Analysis(sql_cur):
    print("\t\t\t Choose among them by typing index \t\t\t")
    print("\t\t\t\t1. Getting a cummulative count of request and complaints lodged by flat \t\t\t")
    print("\t\t\t\t2. Getting the gender-ratio in the RWA \t\t\t")
    print("\t\t\t\t3. Getting the maximum number of visitors in flat \t\t\t")
    ch3i = int(input("Enter final sub_choice > "))
    # ch3i = int(input("Enter final sub_choice > "))
    head = []
    x = PrettyTable()
    if(ch3i == 1):
        head.append("Flat_number")
        head.append("Complaints")
        head.append("Requests")
        # head.append("Total_Residents");
        sql_cur.execute("SELECT B.Flat_number,COUNT(Request_ID),COUNT(Complaint_ID) FROM flats AS B LEFT JOIN requests AS R ON B.Flat_number = R.Flat_number LEFT JOIN complaints AS C ON C.Flat_number = R.Flat_number GROUP BY B.Flat_number UNION SELECT B.Flat_number,COUNT(Request_ID),COUNT(Complaint_ID) FROM flats AS B LEFT JOIN requests AS R ON B.Flat_number = R.Flat_number RIGHT JOIN complaints AS C ON C.Flat_number = R.Flat_number WHERE B.Flat_number <> NULL GROUP BY B.Flat_number")
    if(ch3i == 2):
        head.append("Gender-Ratio")
        # head.append("Total_Requests");
        sql_cur.execute("SELECT COUNT(*) FROM rwa WHERE GENDER = 'Male'")
        for i in sql_cur:
            mal = i[0]
        sql_cur.execute("SELECT COUNT(*) FROM rwa WHERE GENDER = 'Female'")
        for i in sql_cur:
            femal = i[0]
        x.add_row([str((mal/femal))+":1"])
    if(ch3i == 3):
        head.append("Flat_number")
        sql_cur.execute(
            "SELECT Flat_number FROM visitor GROUP BY Flat_Number HAVING COUNT(*) = (SELECT COUNT(*) FROM visitor GROUP BY Flat_number ORDER BY COUNT(*) DESC LIMIT 1)")
    # store = sql_cur.fetchall()
    # print(head)
    x.field_names = head
    for i in sql_cur:
        x.add_row(i)
    print(x)


def routing_func(outch, inch, sql_cur,conn):
    if(outch == "R"):
        if(inch == "1"):
            Select(sql_cur)
        if(inch == "2"):
            Project(sql_cur)
        if(inch == "3"):
            Aggregate(sql_cur)
        if(inch == "4"):
            Search(sql_cur)
        if(inch == "5"):
            Analysis(sql_cur)
    else:
        if(inch == "1"):
            insert(sql_cur,conn)
        if(inch == "3"):
            delete(sql_cur,conn)
        if(inch == "2"):
            update(sql_cur,conn)


def mysqlconnect(username, password_1,db_1):
    # To connect MySQL database
    conn = pymysql.connect(
        host='localhost',
        user=username,
        password=password_1,
        db=db_1, # Change according with databse populated...
    )

    cur = conn.cursor()
    return [cur,conn]

# Driver Code


# while(1):
uname = input("Enter Username : ")
passw = getpass.getpass(prompt="Enter Password: ")
db = input("Enter db : ")


while True:
    try:
        L = mysqlconnect(uname, passw,db)
        sql_cur = L[0]
        conn = L[1]
        # print("hello")
        print("Connected Successfully !")
        print("\n")
        print("\t\t\tSociety Management System\t\t\t")
        print("\t\t\tChoose any :\t\t\t")
        print("\t\t\t\t1. Retrieval- Type R\t\t\t")
        print("\t\t\t\t2. Modification- Type M\t\t\t")
        print("\t\t\tType exit to Exit\t\t\t")
        print("\n")
        chi = input("Enter choice > ")
        if(chi=="exit"):
            print("Exiting...")
            break
        if chi == "R":
            print("\t\t\tChoose by typing index as input")
            print("\t\t\t\t1. Selection\t\t\t")
            print("\t\t\t\t2. Projection\t\t\t")
            print("\t\t\t\t3. Aggregate\t\t\t")
            print("\t\t\t\t4. Search\t\t\t")
            print("\t\t\t\t5. Analysis\t\t\t")
        elif chi == "M":
            print("\t\t\tChoose by typing index as input")
            print("\t\t\t\t1. Insertion\t\t\t")
            print("\t\t\t\t2. Updation\t\t\t")
            print("\t\t\t\t3. Deletion\t\t\t")
        else:
            print("Invalid Input Detected !")
            print("Try again....")
            continue
            # continue
        print("\n")
        ch2i = input("Enter sub_choice > ")
        routing_func(chi, ch2i, sql_cur,conn)
        choice  = input("Want more(y/n) : ")
        if(choice=="n"):
            print("Logged out Successfully !")
            break

    except:
        print("Invalid Credentials")
        print("Try again....")
        break