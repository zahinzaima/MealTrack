package com.mytoken.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import com.mytoken.dao.BookingDAO;
import com.mytoken.model.Booking;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MonthlyDueServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);

        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        if (monthParam != null && yearParam != null) {
            month = Integer.parseInt(monthParam);
            year = Integer.parseInt(yearParam);
        }

        List<Booking> bookings = bookingDAO.getBookingsByUserAndMonth(userId, month, year);
        double totalAmount = bookingDAO.getMonthlyTotal(userId, month, year);

        request.setAttribute("bookings", bookings);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);

        request.getRequestDispatcher("/WEB-INF/views/employee/monthly-due.jsp")
               .forward(request, response);
    }
}