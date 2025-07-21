package com.trainSystem.pkg;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
	
public class usersystem {
	
	public usersystem(){
		
	}
	
	public Connection getConnection() {
		String ourUrl = "jdbc:mysql://localhost:3306/cs336projectdb";
		Connection connection = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		}
		catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(ourUrl,"root", "password");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		usersystem test = new usersystem();
		Connection connection = test.getConnection();
		
		System.out.println(connection);		
		test.closeConnection(connection);
	}
}