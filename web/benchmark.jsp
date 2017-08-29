<%-- 
    Document   : statistics
    Created on : 01.08.2017, 12:15:50
    Author     : rhemmerling
--%>

<%@page import="com.hemmerling.aufgabe05bc_13a_benchmarking.model.BenchmarkManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Statistics</title>
    </head>
    <body>
        <jsp:include page = "header.jsp"/>
        <h1>Statistics</h1>
        <h2>Statistics Filter</h2>
        <table style="width:100%" border="1">
            <tr>
                <th>Request URI</th>
                <th>Values</th>
                <th>Count</th>
                <th>Average</th>
            </tr>
            <% BenchmarkManager benchmarkResult;

               //benchmarkResult = BenchmarkManager.getInstance(); // Singleton 
               benchmarkResult = (BenchmarkManager) application.getAttribute("BENCHMARK_FILTER");

               Map<String, List<Long>> map = benchmarkResult.getBenchmarkingResults();
               for (Map.Entry<String, List<Long>> m : map.entrySet()) {
            %>
            <tr>
                <td>
                    <%= m.getKey()%>
                </td>
                <td>
                    <% int count = 0;
                       long sum = 0L;
                       List<Long> valueArray = (List<Long>) m.getValue();
                       for (Long value : valueArray) {
                           sum +=value;
                           count++;
                    %>
                    <%= value%>                        
                    <%}%>
                </td>
                <td>
                    <%= count %>
                </td>
                <td>
                    <%= sum/count %>
                </td>
            </tr>
            <% }%>
        </table>            
        <h2>Statistics Listener</h2>
        <table style="width:100%" border="1">
            <tr>
                <th>Request URI</th>
                <th>Values</th>
                <th>Count</th>
                <th>Average</th>
            </tr>
            <% BenchmarkManager benchmarkResult2;

               //benchmarkResult2 = BenchmarkManager.getInstance(); // Singleton 
               benchmarkResult2 = (BenchmarkManager) application.getAttribute("BENCHMARK_LISTENER");

               Map<String, List<Long>> map2 = benchmarkResult2.getBenchmarkingResults();
               for (Map.Entry<String, List<Long>> m : map2.entrySet()) {
            %>
            <tr>
                <td>
                    <%= m.getKey()%>
                </td>
                <td>
                    <% int count = 0;
                       long sum = 0L;
                       List<Long> valueArray = (List<Long>) m.getValue();
                       for (Long value : valueArray) {
                           sum +=value;
                           count++;
                    %>
                    <%= value%>                        
                    <%}%>
                </td>
                <td>
                    <%= count %>
                </td>
                <td>
                    <%= sum/count %>
                </td>
            </tr>
            <% }%>
        </table>            
    </body>
</html>
