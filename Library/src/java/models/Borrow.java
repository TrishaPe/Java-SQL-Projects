package models;

import java.sql.Date;

public class Borrow {
    private int bookcode;
    private Date outdate;
    private Date indate;
    private int fine;

    public int getBookcode() {
        return bookcode;
    }

    public void setBookcode(int bookcode) {
        this.bookcode = bookcode;
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

    public int getFine() {
        return fine;
    }

    public void setFine(int fine) {
        this.fine = fine;
    }
    
    
}
