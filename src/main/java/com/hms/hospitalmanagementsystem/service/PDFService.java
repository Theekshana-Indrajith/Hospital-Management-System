//package com.hms.hospitalmanagementsystem.service;
//
//import com.hms.hospitalmanagementsystem.entity.Appointment;
//import com.itextpdf.io.font.constants.StandardFonts;
//import com.itextpdf.kernel.colors.ColorConstants;
//import com.itextpdf.kernel.font.PdfFont;
//import com.itextpdf.kernel.font.PdfFontFactory;
//import com.itextpdf.kernel.pdf.PdfDocument;
//import com.itextpdf.kernel.pdf.PdfWriter;
//import com.itextpdf.layout.Document;
//import com.itextpdf.layout.element.Cell;
//import com.itextpdf.layout.element.Paragraph;
//import com.itextpdf.layout.element.Table;
//import com.itextpdf.layout.properties.TextAlignment;
//import com.itextpdf.layout.properties.UnitValue;
//import org.springframework.stereotype.Service;
//
//import java.io.ByteArrayOutputStream;
//import java.time.format.DateTimeFormatter;
//
//@Service
//public class PDFService {
//
//    public byte[] generateReceiptPDF(Appointment appointment) {
//        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
//            PdfWriter writer = new PdfWriter(baos);
//            PdfDocument pdfDocument = new PdfDocument(writer);
//            Document document = new Document(pdfDocument);
//
//            // Set up fonts
//            PdfFont boldFont = PdfFontFactory.createFont(StandardFonts.HELVETICA_BOLD);
//            PdfFont normalFont = PdfFontFactory.createFont(StandardFonts.HELVETICA);
//
//            // Header
//            Paragraph header = new Paragraph("HOSPITAL MANAGEMENT SYSTEM")
//                    .setFont(boldFont)
//                    .setFontSize(18)
//                    .setFontColor(ColorConstants.BLUE)
//                    .setTextAlignment(TextAlignment.CENTER)
//                    .setMarginBottom(10);
//            document.add(header);
//
//            Paragraph subHeader = new Paragraph("PAYMENT RECEIPT")
//                    .setFont(boldFont)
//                    .setFontSize(16)
//                    .setTextAlignment(TextAlignment.CENTER)
//                    .setMarginBottom(20);
//            document.add(subHeader);
//
//            // Receipt details
//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
//            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
//            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");
//
//            // Receipt Info Table
//            float[] columnWidths = {1, 1};
//            Table infoTable = new Table(UnitValue.createPercentArray(columnWidths));
//            infoTable.setWidth(UnitValue.createPercentValue(100));
//
//            // Receipt Number and Date
//            infoTable.addCell(createCell("Receipt No:", "R" + System.currentTimeMillis(), boldFont, normalFont));
//            infoTable.addCell(createCell("Issue Date:",
//                    java.time.LocalDateTime.now().format(formatter), boldFont, normalFont));
//
//            document.add(infoTable);
//            document.add(new Paragraph("\n"));
//
//// Payment Details Section
//            Paragraph paymentHeader = new Paragraph("PAYMENT DETAILS")
//                    .setFont(boldFont)
//                    .setFontSize(14)
//                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
//                    .setPadding(5)
//                    .setMarginBottom(10);
//            document.add(paymentHeader);
//
//            Table paymentTable = new Table(UnitValue.createPercentArray(columnWidths));
//            paymentTable.setWidth(UnitValue.createPercentValue(100));
//
//            String paymentDate = appointment.getPaymentDate() != null ?
//                    appointment.getPaymentDate().format(formatter) : "N/A";
//
//            paymentTable.addCell(createCell("Transaction ID:", appointment.getTransactionId(), boldFont, normalFont));
//            paymentTable.addCell(createCell("Payment Date:", paymentDate, boldFont, normalFont));
//
//            paymentTable.addCell(createCell("Payment Method:", appointment.getPaymentMethod(), boldFont, normalFont));
//            paymentTable.addCell(createCell("Payment Status:", appointment.getPaymentStatus(), boldFont, normalFont));
//
//// New rows for fees
//            paymentTable.addCell(createCell("Consultation Fee:",
//                    "Rs. " + (appointment.getConsultationFee() != null ? appointment.getConsultationFee() : "0.00"),
//                    boldFont, normalFont));
//            paymentTable.addCell(createCell("Service Fee:",
//                    "Rs. " + (appointment.getServiceFee() != null ? appointment.getServiceFee() : "0.00"),
//                    boldFont, normalFont));
//            paymentTable.addCell(createCell("Total Amount:",
//                    "Rs. " + (appointment.getTotalFee() != null ? appointment.getTotalFee() : "0.00"),
//                    boldFont, normalFont));
//
//            document.add(paymentTable);
//            document.add(new Paragraph("\n"));
//
//// Amount Section (big bold total)
//            Paragraph amountHeader = new Paragraph("AMOUNT PAID")
//                    .setFont(boldFont)
//                    .setFontSize(16)
//                    .setTextAlignment(TextAlignment.CENTER)
//                    .setMarginBottom(10);
//            document.add(amountHeader);
//
//            Paragraph amount = new Paragraph("Rs. " + (appointment.getTotalFee() != null ? appointment.getTotalFee() : "0.00"))
//                    .setFont(boldFont)
//                    .setFontSize(24)
//                    .setFontColor(ColorConstants.GREEN)
//                    .setTextAlignment(TextAlignment.CENTER)
//                    .setMarginBottom(20);
//            document.add(amount);
//
//
//            // Footer
//            Paragraph footer = new Paragraph("Important Notes:\n" +
//                    "• Please bring this receipt and ID proof for your appointment\n" +
//                    "• Arrive 15 minutes before your scheduled appointment time\n" +
//                    "• For cancellations, please inform 24 hours in advance\n" +
//                    "• Keep this receipt for your records and insurance purposes")
//                    .setFont(normalFont)
//                    .setFontSize(10)
//                    .setMarginTop(20);
//
//            document.add(footer);
//
//            Paragraph hospitalInfo = new Paragraph("\nHospital Management System\n" +
//                    "123 Hospital Road, Colombo | Phone: +94 11 234 5678\n" +
//                    "Email: info@hospital.com | www.hospital.com\n" +
//                    "This is a computer generated receipt. No signature required.")
//                    .setFont(normalFont)
//                    .setFontSize(9)
//                    .setTextAlignment(TextAlignment.CENTER)
//                    .setItalic()
//                    .setMarginTop(10);
//
//            document.add(hospitalInfo);
//
//            document.close();
//            return baos.toByteArray();
//
//        } catch (Exception e) {
//            throw new RuntimeException("Error generating PDF receipt", e);
//        }
//    }
//
//    private Cell createCell(String label, String value, PdfFont boldFont, PdfFont normalFont) {
//        Table cellTable = new Table(2);
//        cellTable.setWidth(UnitValue.createPercentValue(100));
//
//        Cell labelCell = new Cell()
//                .add(new Paragraph(label).setFont(boldFont).setFontSize(10))
//                .setBorder(null)
//                .setPadding(2);
//
//        Cell valueCell = new Cell()
//                .add(new Paragraph(value != null ? value : "N/A").setFont(normalFont).setFontSize(10))
//                .setBorder(null)
//                .setPadding(2);
//
//        cellTable.addCell(labelCell);
//        cellTable.addCell(valueCell);
//
//        return new Cell().add(cellTable).setBorder(null).setPadding(5);
//    }
//}

package com.hms.hospitalmanagementsystem.service;

import com.hms.hospitalmanagementsystem.entity.Appointment;
import com.itextpdf.io.font.constants.StandardFonts;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
public class PDFService {

    public byte[] generateReceiptPDF(Appointment appointment) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdfDocument = new PdfDocument(writer);
            Document document = new Document(pdfDocument);

            // Set up fonts
            PdfFont boldFont = PdfFontFactory.createFont(StandardFonts.HELVETICA_BOLD);
            PdfFont normalFont = PdfFontFactory.createFont(StandardFonts.HELVETICA);

            // Header
            Paragraph header = new Paragraph("HOSPITAL MANAGEMENT SYSTEM")
                    .setFont(boldFont)
                    .setFontSize(18)
                    .setFontColor(ColorConstants.BLUE)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(10);
            document.add(header);

            Paragraph subHeader = new Paragraph("PAYMENT RECEIPT")
                    .setFont(boldFont)
                    .setFontSize(16)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(subHeader);

            // Receipt details
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

            // Receipt Info Table
            float[] columnWidths = {1, 1};
            Table infoTable = new Table(UnitValue.createPercentArray(columnWidths));
            infoTable.setWidth(UnitValue.createPercentValue(100));

            // Receipt Number and Date
            infoTable.addCell(createCell("Receipt No:", "R" + System.currentTimeMillis(), boldFont, normalFont));
            infoTable.addCell(createCell("Issue Date:",
                    java.time.LocalDateTime.now().format(formatter), boldFont, normalFont));

            document.add(infoTable);
            document.add(new Paragraph("\n"));

            // Patient and Doctor Information Section
            Paragraph appointmentHeader = new Paragraph("APPOINTMENT INFORMATION")
                    .setFont(boldFont)
                    .setFontSize(14)
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                    .setPadding(5)
                    .setMarginBottom(10);
            document.add(appointmentHeader);

            Table appointmentTable = new Table(UnitValue.createPercentArray(columnWidths));
            appointmentTable.setWidth(UnitValue.createPercentValue(100));

            // Patient Information
            String patientName = appointment.getPatient().getFirstName() + " " + appointment.getPatient().getLastName();
            String patientContact = appointment.getPatient().getContactNumber();
            String patientEmail = appointment.getPatient().getEmail();

            // Doctor Information
            String doctorName = "Dr. " + appointment.getDoctor().getName();
            String doctorSpecialization = appointment.getDoctor().getSpecialization();
            String roomNumber = appointment.getDoctor().getRoomNumber();
            String doctorContact = appointment.getDoctor().getContactNumber();

            appointmentTable.addCell(createCell("Patient Name:", patientName, boldFont, normalFont));
            appointmentTable.addCell(createCell("Patient ID:", "P" + appointment.getPatient().getId(), boldFont, normalFont));
            appointmentTable.addCell(createCell("Patient Contact:", patientContact, boldFont, normalFont));
            appointmentTable.addCell(createCell("Patient Email:", patientEmail, boldFont, normalFont));
            appointmentTable.addCell(createCell("Doctor Name:", doctorName, boldFont, normalFont));
            appointmentTable.addCell(createCell("Specialization:", doctorSpecialization, boldFont, normalFont));
            appointmentTable.addCell(createCell("Room Number:", roomNumber, boldFont, normalFont));
            appointmentTable.addCell(createCell("Doctor Contact:", doctorContact, boldFont, normalFont));
            appointmentTable.addCell(createCell("Appointment Date:",
                    appointment.getAppointmentDateTime().format(dateFormatter), boldFont, normalFont));
            appointmentTable.addCell(createCell("Appointment Time:",
                    appointment.getAppointmentDateTime().format(timeFormatter), boldFont, normalFont));

            document.add(appointmentTable);
            document.add(new Paragraph("\n"));

            // Payment Details Section
            Paragraph paymentHeader = new Paragraph("PAYMENT DETAILS")
                    .setFont(boldFont)
                    .setFontSize(14)
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                    .setPadding(5)
                    .setMarginBottom(10);
            document.add(paymentHeader);

            Table paymentTable = new Table(UnitValue.createPercentArray(columnWidths));
            paymentTable.setWidth(UnitValue.createPercentValue(100));

            String paymentDate = appointment.getPaymentDate() != null ?
                    appointment.getPaymentDate().format(formatter) : "N/A";

            paymentTable.addCell(createCell("Transaction ID:",
                    appointment.getTransactionId() != null ? appointment.getTransactionId() : "N/A", boldFont, normalFont));
            paymentTable.addCell(createCell("Payment Date:", paymentDate, boldFont, normalFont));
            paymentTable.addCell(createCell("Payment Method:",
                    appointment.getPaymentMethod() != null ? appointment.getPaymentMethod() : "N/A", boldFont, normalFont));
            paymentTable.addCell(createCell("Payment Status:",
                    appointment.getPaymentStatus() != null ? appointment.getPaymentStatus() : "N/A", boldFont, normalFont));

            // Fee breakdown with null checks
            Double consultationFee = appointment.getConsultationFee() != null ? appointment.getConsultationFee() : 0.0;
            Double serviceFee = appointment.getServiceFee() != null ? appointment.getServiceFee() : 200.0;
            Double totalFee = appointment.getTotalFee() != null ? appointment.getTotalFee() : (consultationFee + serviceFee);

            paymentTable.addCell(createCell("Consultation Fee:", "Rs. " + String.format("%.2f", consultationFee), boldFont, normalFont));
            paymentTable.addCell(createCell("Service Fee:", "Rs. " + String.format("%.2f", serviceFee), boldFont, normalFont));
            paymentTable.addCell(createCell("Total Amount:", "Rs. " + String.format("%.2f", totalFee), boldFont, normalFont));

            document.add(paymentTable);
            document.add(new Paragraph("\n"));

            // Amount Section (big bold total)
            Paragraph amountHeader = new Paragraph("AMOUNT PAID")
                    .setFont(boldFont)
                    .setFontSize(16)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(10);
            document.add(amountHeader);

            Paragraph amount = new Paragraph("Rs. " + String.format("%.2f", totalFee))
                    .setFont(boldFont)
                    .setFontSize(24)
                    .setFontColor(ColorConstants.GREEN)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(amount);

            // Appointment Reason
            if (appointment.getReason() != null && !appointment.getReason().trim().isEmpty()) {
                Paragraph reasonHeader = new Paragraph("APPOINTMENT REASON")
                        .setFont(boldFont)
                        .setFontSize(12)
                        .setMarginBottom(5);
                document.add(reasonHeader);

                Paragraph reason = new Paragraph(appointment.getReason())
                        .setFont(normalFont)
                        .setFontSize(10)
                        .setMarginBottom(15);
                document.add(reason);
            }

            // Footer
            Paragraph footer = new Paragraph("Important Notes:\n" +
                    "• Please bring this receipt and ID proof for your appointment\n" +
                    "• Arrive 15 minutes before your scheduled appointment time\n" +
                    "• For cancellations, please inform 24 hours in advance\n" +
                    "• Keep this receipt for your records and insurance purposes\n" +
                    "• Present this receipt at the reception for verification")
                    .setFont(normalFont)
                    .setFontSize(10)
                    .setMarginTop(20);

            document.add(footer);

            Paragraph hospitalInfo = new Paragraph("\nHospital Management System\n" +
                    "123 Hospital Road, Colombo | Phone: +94 11 234 5678\n" +
                    "Email: info@hospital.com | www.hospital.com\n" +
                    "This is a computer generated receipt. No signature required.")
                    .setFont(normalFont)
                    .setFontSize(9)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setItalic()
                    .setMarginTop(10);

            document.add(hospitalInfo);

            document.close();
            return baos.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException("Error generating PDF receipt", e);
        }
    }

    private Cell createCell(String label, String value, PdfFont boldFont, PdfFont normalFont) {
        Table cellTable = new Table(2);
        cellTable.setWidth(UnitValue.createPercentValue(100));

        Cell labelCell = new Cell()
                .add(new Paragraph(label).setFont(boldFont).setFontSize(10))
                .setBorder(null)
                .setPadding(2);

        Cell valueCell = new Cell()
                .add(new Paragraph(value != null ? value : "N/A").setFont(normalFont).setFontSize(10))
                .setBorder(null)
                .setPadding(2);

        cellTable.addCell(labelCell);
        cellTable.addCell(valueCell);

        return new Cell().add(cellTable).setBorder(null).setPadding(5);
    }
}