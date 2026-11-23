package com.mytoken.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int userId;
    private String userName;
    private int tokenId;
    private String tokenName;
    private String canteenName;
    private String category;
    private Date bookingDate;
    private int quantity;
    private double totalPrice;
    private String status;
    private Timestamp createdAt;

    public Booking() {}

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public int getTokenId() { return tokenId; }
    public void setTokenId(int tokenId) { this.tokenId = tokenId; }

    public String getTokenName() { return tokenName; }
    public void setTokenName(String tokenName) { this.tokenName = tokenName; }

    public String getCanteenName() { return canteenName; }
    public void setCanteenName(String canteenName) { this.canteenName = canteenName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Date getBookingDate() { return bookingDate; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}