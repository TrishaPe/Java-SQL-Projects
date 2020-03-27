package models;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;

public class Borrow {
    private int bookcode;
    private int personcode;
    private String persontype;
    private Date outdate;
    private Date indate;
    private double fine;

    public int getBookcode() {
        return bookcode;
    }

    public void setBookcode(int bookcode) {
        this.bookcode = bookcode;
    }

    public int getPersoncode() {
        return personcode;
    }

    public void setPersoncode(int personcode) {
        this.personcode = personcode;
    }

    public String getPersontype() {
        return persontype;
    }

    public void setPersontype(String persontype) {
        this.persontype = persontype;
    }
    
    public Date getOutdate() {
        return outdate;
    }

    public void setOutdate(Date outdate) {
        this.outdate = outdate;
    }

    public Date getIndate() {
        return indate;
    }

    public void setIndate(Date indate) {
        this.indate = indate;
    }

    public double getFine() {
        return fine;
    }

    public void setFine() {
        //Create a LocalDate object for the day of today
        LocalDate now = (LocalDate.now()).parse("2017-06-22");
        //Convert outdate (sql.Date) into a LocalDate
        LocalDate indate1 = (indate.toLocalDate()).parse("2017-06-22");
        //To convert LocalDate to SQL.date: java.sql.Date sqlDate = java.sql.Date.valueOf( todayLocalDate );
        int difference=now.compareTo(indate1);
        if (difference>0){ //returns 0 if dates are equal, positive value if “this date” is greater than the otherDate, It returns negative value if “this date” is less than the otherDate.
            if (persontype.equals("student")){
                this.fine=difference*0.5;
            }else{
                this.fine=difference*0.3;
            }
        }
        //else: fine is not set and will be null
    }
    
    
}
