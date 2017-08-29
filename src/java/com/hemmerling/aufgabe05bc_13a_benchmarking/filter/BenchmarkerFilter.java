/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hemmerling.aufgabe05bc_13a_benchmarking.filter;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import com.hemmerling.aufgabe05bc_13a_benchmarking.model.BenchmarkManager;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 *
 * @author rhemmerling
 */
@WebFilter(filterName = "BenchmarkerFilter_Annotation_JSP", 
           // servletNames = { "/" },
           urlPatterns = { "*.jsp", "/" })
public class BenchmarkerFilter implements Filter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        BenchmarkManager benchmarkResult = new BenchmarkManager();
        ServletContext context2 = filterConfig.getServletContext();
        context2.setAttribute("BENCHMARK_FILTER", benchmarkResult);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        long startTime, endTime;

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String requestURI = httpRequest.getRequestURI();
        ServletContext context2 = request.getServletContext();
        BenchmarkManager benchmarkResult = (BenchmarkManager) context2.getAttribute("BENCHMARK_FILTER");

        System.out.println("**************** MyFilter-VORHER ****************");
        System.out.println(request + ": initialized");
        startTime = System.currentTimeMillis();
        // startTime = System.nanoTime();
        chain.doFilter(request, response);
        endTime = System.currentTimeMillis();
        long duration = endTime - startTime;
        benchmarkResult.addBenchmarkingResults(requestURI, duration);

        System.out.format("Execution time for the URL: '%s' ist: %d ms%n",
                requestURI, duration);
        System.out.println(request + ": destroyed");
        System.out.println("**************** MyFilter-NACHHER ****************");
    }

    @Override
    public void destroy() {
    }

}
   