package com.mytoken.model;

public class Canteen {
    private int canteenId;
    private String name;
    private String openingTime;
    private String closingTime;
    private String status;

    public Canteen() {}

    public Canteen(int canteenId, String name, String openingTime, 
                   String closingTime, String status) {
        this.canteenId = canteenId;
        this.name = name;
        this.openingTime = openingTime;
        this.closingTime = closingTime;
        this.status = status;
    }

    public int getCanteenId() { return canteenId; }
    public void setCanteenId(int canteenId) { this.canteenId = canteenId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getOpeningTime() { return openingTime; }
    public void setOpeningTime(String openingTime) { this.openingTime = openingTime; }

    public String getClosingTime() { return closingTime; }
    public void setClosingTime(String closingTime) { this.closingTime = closingTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}