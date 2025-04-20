import streamlit as st
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
from datetime import datetime
from dotenv import load_dotenv
import os

load_dotenv()

password = os.getenv("SQL_PASSWORD")

# Function to connect to the database
def connect_to_db():
    try:
        connection = mysql.connector.connect(
            host="localhost",  # Replace with your host, 'localhost' if running locally
            user="root",       # Your MySQL username
            password=password,  # Your MySQL password
            database="food_ordering_system",  # Your database name
            auth_plugin="mysql_native_password"  # Specify authentication plugin
        )
        return connection
    except mysql.connector.Error as err:
        st.error(f"Error: {err}")
        return None

# Function to fetch restaurant data for analysis
def get_restaurant_data():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT r.name AS restaurant_name, COUNT(o.order_id) AS order_count, SUM(o.total_amount) AS total_sales
            FROM Orders o
            JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
            GROUP BY r.name;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return None

# Function to fetch orders data for analysis
def get_orders_data():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT o.order_id, o.total_amount, o.order_time, r.name AS restaurant_name
            FROM Orders o
            JOIN Restaurants r ON o.restaurant_id = r.restaurant_id;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return None

# Function to get the most liked dish
def get_most_liked_dish():
    connection = connect_to_db()
    if connection:
        query = """
           SELECT D.name AS dish_name, COUNT(*) AS order_count
           FROM OrderItems OI
           JOIN Dishes D ON OI.dish_id = D.dish_id
           GROUP BY D.dish_id
           ORDER BY order_count DESC
           LIMIT 1;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df.iloc[0]['dish_name']
    return None

# Function to calculate average order value of customers
def get_avg_order_value():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT AVG(total_amount) AS avg_order_value
            FROM Orders;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df.iloc[0]['avg_order_value']
    return None

# Function to get total number of orders
def get_total_orders():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT COUNT(order_id) AS total_orders
            FROM Orders;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df.iloc[0]['total_orders']
    return None

# Function to get total sales for today
def get_total_sales_today():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT SUM(total_amount) AS total_sales_today
            FROM Orders
            WHERE DATE(order_time) = CURDATE();
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df.iloc[0]['total_sales_today']
    return None

# Function to get the number of restaurants
def get_num_restaurants():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT COUNT(*) AS num_restaurants
            FROM Restaurants;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df.iloc[0]['num_restaurants']
    return None

# Function to fetch reviews data for a specific restaurant
def get_reviews_data_by_restaurant(restaurant_id):
    connection = connect_to_db()
    if connection:
        query = f"""
            SELECT c.name AS customer_name, d.name AS dish_name, r.rating, r.review_text, r.review_date
            FROM Reviews r
            JOIN Customers c ON r.customer_id = c.customer_id
            JOIN Dishes d ON r.dish_id = d.dish_id
            WHERE r.restaurant_id = {restaurant_id}
            ORDER BY r.review_date DESC
            LIMIT 10;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return None

def get_customer_list():
    connection = connect_to_db()
    if connection:
        query = "SELECT customer_id, name FROM Customers;"
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return pd.DataFrame()

def get_restaurant_list():
    connection = connect_to_db()
    if connection:
        query = "SELECT restaurant_id, name FROM Restaurants;"
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return pd.DataFrame()

# Function to display reviews by restaurant
def display_reviews_by_restaurant(restaurant_id,selected_restaurant_name ):
    reviews = get_reviews_data_by_restaurant(restaurant_id)
    if reviews is not None and not reviews.empty:
        st.subheader(f"Recent Reviews for {selected_restaurant_name}")
    
        for index, row in reviews.iterrows():
            st.write(f"**{row['customer_name']}** gave a rating of {row['rating']} for the dish **{row['dish_name']}**")
            st.write(f"Review: {row['review_text']}")
            st.write(f"Date: {row['review_date']}")
            st.markdown("---")
    else:
        st.write("No reviews available for this restaurant.")

# Function to fetch customer insights
def get_customer_insights():
    connection = connect_to_db()
    if connection:
        query = """
            SELECT c.name AS customer_name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
            FROM Orders o
            JOIN Customers c ON o.customer_id = c.customer_id
            GROUP BY c.name
            ORDER BY total_spent DESC
            LIMIT 5;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return None


#Restraunt Insights
def get_restaurant_insights(restaurant_id):
    connection = connect_to_db()
    if connection:
        query = f"""
            SELECT r.name AS restaurant_name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_sales
            FROM Orders o
            JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
            WHERE r.restaurant_id = {restaurant_id}
            GROUP BY r.name;
        """
        df = pd.read_sql(query, connection)
        connection.close()
        return df
    return None

def add_order(customer_id, restaurant_id, total_amount, order_time):
    connection = connect_to_db()
    if connection:
        try:
            cursor = connection.cursor()
            query = """
                INSERT INTO Orders (customer_id, restaurant_id, total_amount, order_time)
                VALUES (%s, %s, %s, %s);
            """
            cursor.execute(query, (customer_id, restaurant_id, total_amount, order_time))
            connection.commit()
            cursor.close()
            connection.close()
            return True
        except mysql.connector.Error as err:
            st.error(f"Error: {err}")
            return False
    return False



# Main Streamlit function
def main():
    
    # Fetch restaurant-specific sales data
    restaurant_data = get_restaurant_data()

    # Add one more metric here (for example, Total Orders)
    total_orders = get_total_orders()

    st.title("Sales Analysis Dashboard")
    st.header("Restaurant Performance Overview")
    
    # 2x2 Grid of Metrics (Big Numbers)
    st.subheader("Key Metrics Overview")
    col1, col2 = st.columns(2)
    with col1:
        # Total Sales for the Day
        total_sales_today = get_total_sales_today()
        if total_sales_today is not None:
            st.markdown(f"<h2 style='color: #2f7ed8;'>₹{total_sales_today:.2f}</h2>", unsafe_allow_html=True)
        else:
            st.markdown("<h2 style='color: #2f7ed8;'>₹0.00</h2>", unsafe_allow_html=True)
        st.write("**Total Sales Today**")

    with col2:
        # Number of Restaurants
        num_restaurants = get_num_restaurants()
        if num_restaurants is not None:
            st.markdown(f"<h2 style='color: #e9444d;'>{num_restaurants}</h2>", unsafe_allow_html=True)
        else:
            st.markdown("<h2 style='color: #e9444d;'>0</h2>", unsafe_allow_html=True)
        st.write("**Total Restaurants**")

    col3, col4 = st.columns(2)
    with col3:
        # Average Sales per Restaurant
        if restaurant_data is not None and len(restaurant_data) > 0:
            avg_sales_per_restaurant = restaurant_data['total_sales'].sum() / len(restaurant_data)
            st.markdown(f"<h2 style='color: #28a745;'>₹{avg_sales_per_restaurant:.2f}</h2>", unsafe_allow_html=True)
        else:
            st.markdown("<h2 style='color: #28a745;'>₹0.00</h2>", unsafe_allow_html=True)
        st.write("**Avg Sales per Restaurant**")

    with col4:
        # Total Orders
        if total_orders is not None:
            st.markdown(f"<h2 style='color: #ffc107;'>{total_orders}</h2>", unsafe_allow_html=True)
        else:
            st.markdown("<h2 style='color: #ffc107;'>0</h2>", unsafe_allow_html=True)
        st.write("**Total Orders**")
    
    # Fetch key metrics (textual insights)
    most_liked_dish = get_most_liked_dish()
    avg_order_value = get_avg_order_value()

    # Display metrics in columns
    col1, col2 = st.columns(2)
    with col1:
        if most_liked_dish is not None:
            st.markdown(f"<h2 style='color: #b907f7;'>{most_liked_dish}</h2>", unsafe_allow_html=True)
        else:
            st.markdown("<h2 style='color: #2f7ed8;'>None</h2>", unsafe_allow_html=True)
        st.write("**Most Liked Dish**")

    with col2:
        if avg_order_value is not None:
            st.markdown(f"<h2 style='color: #f707aa  ;'>₹{avg_order_value:.2f}</h2>", unsafe_allow_html=True)
        else:
            st.markdown("<h2 style='color: #f1948a;'>0</h2>", unsafe_allow_html=True)
        st.write("**Average Order Value**")

    # with col2:
    #     st.subheader("Average Order Value")
    #     st.write(f"The average order value is: **₹{avg_order_value:.2f}**.")

    st.header("Add a New Order")

    # Load customer and restaurant data
    customers_df = get_customer_list()
    restaurants_df = get_restaurant_list()

    with st.form("add_order_form"):
        customer_name = st.selectbox("Select Customer", customers_df['name'].tolist())
        restaurant_name = st.selectbox("Select Restaurant", restaurants_df['name'].tolist())
        total_amount = st.number_input("Total Amount (₹)", min_value=0.0, format="%.2f")

        order_date = st.date_input("Order Date")
        order_time_only = st.time_input("Order Time")
        order_time = datetime.combine(order_date, order_time_only)

        submitted = st.form_submit_button("Submit Order")
        if submitted:
            # Get IDs from selected names
            customer_id = int(customers_df[customers_df['name'] == customer_name]['customer_id'].values[0])
            restaurant_id = int(restaurants_df[restaurants_df['name'] == restaurant_name]['restaurant_id'].values[0])

            
            success = add_order(customer_id, restaurant_id, total_amount, order_time)
            if success:
                st.success("Order added successfully!")
            else:
                st.error("Failed to add order.")


    if restaurant_data is not None:
        st.subheader("Total Sales by Restaurant")
        fig, ax = plt.subplots(figsize=(10, 6))
        sns.barplot(data=restaurant_data, x='restaurant_name', y='total_sales', palette='Spectral', ax=ax)
        ax.set_xticklabels(ax.get_xticklabels(), rotation=45, ha='right', fontsize=10)
        ax.set_xlabel('Restaurant', fontsize=12)
        ax.set_ylabel('Total Sales (INR)', fontsize=12)
        ax.set_title('Total Sales by Restaurant', fontsize=14)
        st.pyplot(fig)

    # Fetch orders data for more analysis
    orders_data = get_orders_data()

    # Simultaneous Graphs - Average Order Value by Restaurant (Pie chart)
    st.subheader("Order Distribution by Restaurant")
    fig2 = px.pie(restaurant_data, names='restaurant_name', values='order_count', 
                  title='Number of Orders by Restaurant', 
                  color='restaurant_name', 
                  color_discrete_sequence=px.colors.qualitative.Set3)
    st.plotly_chart(fig2)

    # Simultaneous Graph - Orders by Day
    st.subheader("Orders by Day")
    fig3, ax3 = plt.subplots(figsize=(10, 6))
    orders_data['order_date'] = pd.to_datetime(orders_data['order_time']).dt.date
    daily_sales = orders_data.groupby('order_date')['total_amount'].sum().reset_index()

    sns.lineplot(data=daily_sales, x='order_date', y='total_amount', ax=ax3, palette='muted')
    ax3.set_xlabel('Order Date', fontsize=12)
    ax3.set_ylabel('Total Sales (INR)', fontsize=12)
    ax3.set_title('Total Sales by Day', fontsize=14)
    st.pyplot(fig3)

  # Customer Insights
    customer_insights = get_customer_insights()
    if customer_insights is not None and not customer_insights.empty:
        st.subheader("Top 5 Customers Based on Spending")
        for index, row in customer_insights.iterrows():
            st.write(f"***{row['customer_name']}*** made {row['total_orders']} orders, spending ₹{row['total_spent']:.2f}.")
    else:
        st.write("No customer insights available.")

    st.header("Restaurant Insights")
    # Reviews and Customer Insights Section
    restaurant_options = restaurant_data['restaurant_name'].unique()  # Get unique restaurant names
    selected_restaurant = st.selectbox("Select a Restaurant", restaurant_options)  # Dropdown for restaurant selection
    
    # Fetch the corresponding restaurant_id
    selected_restaurant_id = restaurant_data[restaurant_data['restaurant_name'] == selected_restaurant].index[0] + 1  # Assuming restaurant_id starts from 1

    #Fetch the corresponding Restraunt Name
    selected_restaurant_name = restaurant_data[restaurant_data['restaurant_name'] == selected_restaurant]['restaurant_name'].values[0]
    display_reviews_by_restaurant(selected_restaurant_id ,selected_restaurant_name )

    # Restaurant Insights
    restaurant_insights =get_restaurant_insights(selected_restaurant_id)
    if restaurant_insights is not None and not restaurant_insights.empty:
        st.subheader(f"Metrics for {selected_restaurant}")
        st.write(f"Total Orders: {restaurant_insights.iloc[0]['total_orders']}")
        st.write(f"Total Sales: ₹{restaurant_insights.iloc[0]['total_sales']:.2f}")
    else:
        st.write("No insights available for this restaurant.")

  
    
if __name__ == "__main__":
    main()
