package models;

public class Book {
    private int bookcode;
    private int isbn;
    private String title;
    private int autcode;
    private String autname;
    private String notes;
    private String genre;

    public int getBookcode() {
        return bookcode;
    }

    public void setBookcode(int bookcode) {
        this.bookcode = bookcode;
    }

    public int getIsbn() {
        return isbn;
    }

    public void setIsbn(int isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAutcode() {
        return autcode;
    }

    public void setAutcode(int autcode) {
        this.autcode = autcode;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getAutname() {
        return autname;
    }

    public void setAutname(String autname) {
        this.autname = autname;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }
    
}
