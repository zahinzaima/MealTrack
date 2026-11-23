package com.mytoken.model;

public class Token {
    private int tokenId;
    private String tokenCode;
    private String tokenName;
    private int canteenId;
    private String canteenName;
    private String category;
    private double price;
    private String availableDays;
    private String status;

    public Token() {}

    public Token(int tokenId, String tokenCode, String tokenName, int canteenId,
                 String category, double price, String availableDays, String status) {
        this.tokenId = tokenId;
        this.tokenCode = tokenCode;
        this.tokenName = tokenName;
        this.canteenId = canteenId;
        this.category = category;
        this.price = price;
        this.availableDays = availableDays;
        this.status = status;
    }

    public int getTokenId() { return tokenId; }
    public void setTokenId(int tokenId) { this.tokenId = tokenId; }

    public String getTokenCode() { return tokenCode; }
    public void setTokenCode(String tokenCode) { this.tokenCode = tokenCode; }

    public String getTokenName() { return tokenName; }
    public void setTokenName(String tokenName) { this.tokenName = tokenName; }

    public int getCanteenId() { return canteenId; }
    public void setCanteenId(int canteenId) { this.canteenId = canteenId; }

    public String getCanteenName() { return canteenName; }
    public void setCanteenName(String canteenName) { this.canteenName = canteenName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}