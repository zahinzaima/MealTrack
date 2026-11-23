package com.mytoken.model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String pin;
    private String role;
    private String department;
    private String designation;
    private String status;

    public User() {}

    public User(int userId, String name, String email, String pin, 
                String role, String department, String designation, String status) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.pin = pin;
        this.role = role;
        this.department = department;
        this.designation = designation;
        this.status = status;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPin() { return pin; }
    public void setPin(String pin) { this.pin = pin; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}