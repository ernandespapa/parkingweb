/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fatecpg.parking;
    
import java.util.ArrayList;
import java.util.Date;

public class Period {
    private long id;
    private String model;
    private String plate;
    private Date begin;
    private Date end;
    private double price;

    public Period(long id, String model, String plate, Date begin) {
        this.id = id;
        this.model = model;
        this.plate = plate;
        this.begin = begin;
    }

    public Period(long id, String model, String plate, Date begin, Date end, double price) {
        this.id = id;
        this.model = model;
        this.plate = plate;
        this.begin = begin;
        this.end = end;
        this.price = price;
    }

 

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getPlate() {
        return plate;
    }

    public void setPlate(String plate) {
        this.plate = plate;
    }

    public Date getBegin() {
        return begin;
    }

    public void setBegin(Date begin) {
        this.begin = begin;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
        public static Period getPeriod(long id) throws Exception{
        String SQL = "SELECT * FROM PARKING_PERIODS WHERE ID = ?";
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{id});
        if(list.isEmpty()){
            return null;
        }else{
            Object row[] = list.get(0);
            Period p = new Period (
                    (long) row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (Date) row[3]);
                   
                    
                    return p;   
        }
       
        }
  public static ArrayList<Period> getHistory(String date, String plate) throws Exception{
      String SQL = "SELECT * FROM PARKING_PERIODS WHERE END_PERIOD IS NOT NULL ORDER BY BEGIN_PERIOD";
        ArrayList<Period> periods = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
       /* ArrayList<Object[]> list = null;
        if (date == null && plate != null){
            String SQL = "SELECT * FROM PARKING_PERIODS ";
            SQL += " WHERE plate = ?";
            SQL += " ORDER BY BEGIN_PERIOD";
            list = DatabaseConnector.getQuery(SQL, new Object[]{plate});
            
        }else if (date != null && plate == null){
            String SQL = "SELECT * FROM PARKING_PERIODS ";
            SQL += " WHERE VARCHAR(DATE(BEGIN_PERIOD)) = ?";
            SQL += " ORDER BY BEGIN_PERIOD";
            list = DatabaseConnector.getQuery(SQL, new Object[]{date});      
         }else if (date != null && plate != null){
            String SQL = "SELECT * FROM PARKING_PERIODS ";
            SQL += " WHERE VARCHAR(DATE(BEGIN_PERIOD)) = ? AND plate= ?";
            SQL += " ORDER BY BEGIN_PERIOD";
            list = DatabaseConnector.getQuery(SQL, new Object[]{date, plate});   
        }else{
             String SQL = "SELECT * FROM PARKING_PERIODS ";
            SQL += " ORDER BY BEGIN_PERIOD";
            list = DatabaseConnector.getQuery(SQL, new Object[]{});
        }*/

       // ArrayList<Period> periods = new ArrayList<>();
       for (int i = 0; i<list.size(); i++) {
            Object row[] = list.get(i);
            Period p = new Period (
                    (long) row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (Date) row[3]
                    , (Date) row[4]
                    , (Double) row[5]);
                   
                    periods.add(p);
        }     
            return periods;
        }
        public static ArrayList<Period> getPeriods() throws Exception{
        String SQL = "SELECT * FROM PARKING_PERIODS WHERE END_PERIOD IS NULL ORDER BY BEGIN_PERIOD";
        ArrayList<Period> periods = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
       for (int i = 0; i<list.size(); i++) {
            Object row[] = list.get(i);
            Period p = new Period (
                    (long) row[0]
                    , (String) row[1]
                    , (String) row[2]
                    , (Date) row[3]);
                   
                    periods.add(p);
        }     
            return periods;
        }
     
      public static void addPeriod(String model, String plate)throws Exception{
          String SQL = "INSERT INTO PARKING_PERIODS VALUES("
               + "default"
               + ", ?"
               + ", ?"
               + ", ?"
               + ", null"
               + ", null"
               + ")";
          
          Object parameters[] = {model, plate, new Date()};
          DatabaseConnector.execute(SQL, parameters);      
      }
      
        public static void finishPeriod(long id, double price)throws Exception{
          String SQL = "UPDATE PARKING_PERIODS "
               + " SET END_PERIOD = ? "
               + ", PRICE = ? "
               + " WHERE ID = ?";
                 
          Object parameters[] = {new Date(), price, id};
          DatabaseConnector.execute(SQL, parameters);      
      }
}
