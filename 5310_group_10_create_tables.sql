CREATE TABLE account (
    account_id INT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
	PRIMARY KEY (account_id)
);

CREATE TABLE address (
    address_id INT,
    detailed_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip_code VARCHAR(255) NOT NULL,
	PRIMARY KEY (address_id)
);

CREATE TABLE customer (
    customer_id INT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    address INT NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
	PRIMARY KEY (customer_id),
	FOREIGN KEY (address) REFERENCES address(address_id)
);

CREATE TABLE payment (
    payment_id INT,
    payer_id INT NOT NULL,
    payment_method VARCHAR(255) NOT NULL,
    payment_amount DECIMAL(12, 2) NOT NULL,
	payment_date TIMESTAMP NOT NULL,
	PRIMARY KEY (payment_id),
	FOREIGN KEY (payer_id) REFERENCES customer(customer_id)
);

CREATE TABLE booking (
    booking_id INT,
    account_id INT NOT NULL,
	payment_id INT NOT NULL,
	PRIMARY KEY (booking_id),
	FOREIGN KEY (account_id) REFERENCES account(account_id),
	FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);


CREATE TABLE vehicle (
    vehicle_id INT,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT NOT NULL,
	hourly_rate DECIMAL(12,2) NOT NULL,
	PRIMARY KEY (vehicle_id)
);

CREATE TABLE car_rental_company (
    car_rental_company_id INT,
    car_rental_company_name VARCHAR(255) NOT NULL,
	PRIMARY KEY (car_rental_company_id)
);

CREATE TABLE car_rental_order (
    car_rental_order_id INT,
	car_rental_company INT NOT NULL,
    vehicle_id INT NOT NULL,
    pick_up_time TIMESTAMP NOT NULL,
    pick_up_location INT NOT NULL,
    drop_time TIMESTAMP NOT NULL,
    drop_off_location INT NOT NULL,
	PRIMARY KEY (car_rental_order_id),
	FOREIGN KEY (pick_up_location) REFERENCES address(address_id),
	FOREIGN KEY (drop_off_location) REFERENCES address(address_id),
	FOREIGN KEY (car_rental_company) REFERENCES car_rental_company(car_rental_company_id)
);


CREATE TABLE booking_car_rental_order (
    id INT,
	booking_id INT NOT NULL,
    car_rental_order_id INT NOT NULL UNIQUE,
	PRIMARY KEY (id),
	FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
	FOREIGN KEY (car_rental_order_id) REFERENCES car_rental_order(car_rental_order_id)
);

CREATE TABLE airline_company (
    airline_company_id INT,
    airline_company_name VARCHAR(255) NOT NULL,
	PRIMARY KEY (airline_company_id)
);

CREATE TABLE ticket (
    ticket_id INT,
	airline_company INT NOT NULL,
    flight_number VARCHAR(255) NOT NULL,
	departure_airport_address INT NOT NULL,
	arrival_airport_address INT NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    departure_time TIMESTAMP NOT NULL,
	seat_number VARCHAR(255) NOT NULL,
	ticket_price DECIMAL(12,2) NOT NULL,
	PRIMARY KEY (ticket_id),
	FOREIGN KEY (departure_airport_address) REFERENCES address(address_id),
	FOREIGN KEY (arrival_airport_address) REFERENCES address(address_id),
	FOREIGN KEY (airline_company) REFERENCES airline_company(airline_company_id)
);

CREATE TABLE booking_ticket (
    id INT,
	booking_id INT NOT NULL,
    ticket_id INT NOT NULL UNIQUE,
	PRIMARY KEY (id),
	FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
	FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)
);

CREATE TABLE hotel (
    hotel_id INT,
    hotel_name VARCHAR(255) NOT NULL,
    hotel_address INT NOT NULL,
	PRIMARY KEY (hotel_id),
	FOREIGN KEY (hotel_address) REFERENCES address(address_id)
);

CREATE TABLE hotel_order (
    hotel_order_id INT,
	hotel_id INT NOT NULL,
    room_number VARCHAR(255) NOT NULL,
	room_floor INT NOT NULL,
    check_in_date TIMESTAMP NOT NULL,
    check_out_date TIMESTAMP NOT NULL,
	daily_rate DECIMAL(12,2) NOT NULL,
	PRIMARY KEY (hotel_order_id),
	FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id)
);

CREATE TABLE booking_hotel_order (
    id INT,
	booking_id INT NOT NULL,
    hotel_order_id INT NOT NULL UNIQUE,
	PRIMARY KEY (id),
	FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
	FOREIGN KEY (hotel_order_id) REFERENCES hotel_order(hotel_order_id)
);

CREATE TABLE booking_customer (
    id INT,
	booking_id INT NOT NULL,
    customer_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);