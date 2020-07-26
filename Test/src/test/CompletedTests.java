package test;

import java.sql.Date;
import java.time.LocalDate;
//import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class CompletedTests {
    
    public double CalcFine(Date indate){
        //create LocalDate:
        //String inputString1 = "30 04 2020";
        //DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd MM yyyy");
        //LocalDate indate = LocalDate.parse(inputString1, dtf);
        
        //Turn java.sql.Date into java.time.LocalDate:
        LocalDate indate1 = indate.toLocalDate();
        
        String persontype="staff";
        

        LocalDate now = (LocalDate.now());
        System.out.println("date now="+now);
        long difference= ChronoUnit.DAYS.between(indate1, now);
        System.out.println("difference="+difference);
        double fine=0;
        if (difference>0){
            if (persontype.equals("student")){
                fine=difference*0.5;
                System.out.println("student fine="+fine);
            }else{
                fine=difference*0.3;
                System.out.println(fine);
                System.out.println("staff fine="+fine);
            }
        }
        return fine;
    }
    
}
