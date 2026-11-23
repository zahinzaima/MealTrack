package com.mytoken.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

import com.mytoken.dao.BookingDAO;
import com.mytoken.dao.TokenDAO;
import com.mytoken.model.Booking;
import com.mytoken.model.Token;
import com.mytoken.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();
    private TokenDAO tokenDAO = new TokenDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        String action = request.getParameter("action");

        if ("single".equals(action)) {
            bookSingle(request, response, userId);
        } else if ("bulk".equals(action)) {
            bookBulk(request, response, userId);
        } else if ("cancel".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDAO.cancelBooking(bookingId, userId);
            response.sendRedirect(request.getContextPath() + "/employee/dashboard");
        }
    }

    private void bookSingle(HttpServletRequest request, HttpServletResponse response,
                            int userId) throws IOException {
        try {
            int tokenId = Integer.parseInt(request.getParameter("tokenId"));
            String dateStr = request.getParameter("bookingDate");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Date bookingDate = Date.valueOf(dateStr);

            // Validate: cannot book today or past
            Calendar today = Calendar.getInstance();
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            today.set(Calendar.MILLISECOND, 0);

            if (bookingDate.before(new Date(today.getTimeInMillis()))) {
                response.sendRedirect(request.getContextPath() +
                    "/employee/dashboard?error=Cannot+book+for+past+dates");
                return;
            }

            if (bookingDAO.isAlreadyBooked(userId, tokenId, bookingDate)) {
                response.sendRedirect(request.getContextPath() +
                    "/employee/dashboard?error=Already+booked+for+this+date");
                return;
            }

            Token token = tokenDAO.getTokenById(tokenId);
            double totalPrice = token.getPrice() * quantity;

            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setTokenId(tokenId);
            booking.setBookingDate(bookingDate);
            booking.setQuantity(quantity);
            booking.setTotalPrice(totalPrice);

            bookingDAO.addBooking(booking);
            response.sendRedirect(request.getContextPath() +
                "/employee/dashboard?success=Token+booked+successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                "/employee/dashboard?error=Booking+failed");
        }
    }

    private void bookBulk(HttpServletRequest request, HttpServletResponse response,
                          int userId) throws IOException {
        try {
            int tokenId = Integer.parseInt(request.getParameter("tokenId"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);

            Token token = tokenDAO.getTokenById(tokenId);
            String availableDays = token.getAvailableDays();

            Calendar cal = Calendar.getInstance();
            cal.setTime(startDate);
            String[] dayNames = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};

            int booked = 0;
            while (!cal.getTime().after(endDate)) {
                String dayName = dayNames[cal.get(Calendar.DAY_OF_WEEK) - 1];
                if (availableDays.contains(dayName)) {
                    Date bookingDate = new Date(cal.getTimeInMillis());
                    if (!bookingDAO.isAlreadyBooked(userId, tokenId, bookingDate)) {
                        Booking booking = new Booking();
                        booking.setUserId(userId);
                        booking.setTokenId(tokenId);
                        booking.setBookingDate(bookingDate);
                        booking.setQuantity(quantity);
                        booking.setTotalPrice(token.getPrice() * quantity);
                        bookingDAO.addBooking(booking);
                        booked++;
                    }
                }
                cal.add(Calendar.DATE, 1);
            }

            response.sendRedirect(request.getContextPath() +
                "/employee/dashboard?success=Bulk+booking+successful+" + booked + "+days");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                "/employee/dashboard?error=Bulk+booking+failed");
        }
    }
}