package com.mytoken.model;

public class MonthlyDue {
    private int dueId;
    private int userId;
    private String userName;
    private int month;
    private int year;
    private double totalAmount;
    private boolean isDeducted;

    public MonthlyDue() {}

    public int getDueId() { return dueId; }
    public void setDueId(int dueId) { this.dueId = dueId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public int getMonth() { return month; }
    public void setMonth(int month) { this.month = month; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public boolean isDeducted() { return isDeducted; }
    public void setDeducted(boolean isDeducted) { this.isDeducted = isDeducted; }
}