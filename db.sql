-- Создание таблицы книг (Books)
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title NVARCHAR(255),
    author_id INT,
    genre_id INT,
    price DECIMAL(10, 2),
    publication_date DATE,
    description NVARCHAR(MAX)
);

-- Создание таблицы авторов (Authors)
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name NVARCHAR(100)
);

-- Создание таблицы жанров (Genres)
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY,
    genre_name NVARCHAR(100)
);

-- Создание таблицы клиентов (Customers)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(100),
    email NVARCHAR(100),
    address NVARCHAR(255)
);

-- Создание таблицы заказов (Orders)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы деталей заказов (Order_Details)
CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Создание таблицы отзывов (Reviews)
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    rating INT,
    comment NVARCHAR(MAX),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы списка желаемого (Wishlist)
CREATE TABLE Wishlist (
    wishlist_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Создание таблицы корзины (Cart)
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Создание таблицы администраторов (Admins)
CREATE TABLE Admins (
    admin_id INT PRIMARY KEY,
    admin_name NVARCHAR(100),
    username NVARCHAR(100),
    password NVARCHAR(100)
);

-- Создание таблицы деталей доставки (Shipping_Details)
CREATE TABLE Shipping_Details (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    address NVARCHAR(255),
    shipping_date DATE,
    status NVARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Таблица платежей (Payments)
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_status NVARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Таблица скидок (Discounts)
CREATE TABLE Discounts (
    discount_id INT PRIMARY KEY,
    discount_code NVARCHAR(50),
    discount_amount DECIMAL(10, 2),
    start_date DATE,
    end_date DATE
);

-- Таблица категорий книг (BookCategories)
CREATE TABLE BookCategories (
    category_id INT PRIMARY KEY,
    category_name NVARCHAR(100)
);

-- Таблица связи книг и их категорий (Book_Category_Link)
CREATE TABLE Book_Category_Link (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (category_id) REFERENCES BookCategories(category_id)
);

-- Таблица издательств (Publishers)
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name NVARCHAR(100),
    headquarters_location NVARCHAR(255)
);

-- Таблица связи книг и их издателей (Book_Publisher_Link)
CREATE TABLE Book_Publisher_Link (
    book_id INT,
    publisher_id INT,
    PRIMARY KEY (book_id, publisher_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

-- Таблица авторских прав (Copyrights)
CREATE TABLE Copyrights (
    copyright_id INT PRIMARY KEY,
    book_id INT,
    copyright_year INT,
    holder_name NVARCHAR(100),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Таблица оценок пользователей (UserRatings)
CREATE TABLE UserRatings (
    rating_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    user_rating DECIMAL(3, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Таблица сессий пользователей (UserSessions)
CREATE TABLE UserSessions (
    session_id INT PRIMARY KEY,
    customer_id INT,
    login_time DATETIME,
    logout_time DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Таблица логов активности (ActivityLogs)
CREATE TABLE ActivityLogs (
    log_id INT PRIMARY KEY,
    customer_id INT,
    activity_description NVARCHAR(MAX),
    activity_time DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Таблица рекомендаций (Recommendations)
CREATE TABLE Recommendations (
    recommendation_id INT PRIMARY KEY,
    book_id INT,
    recommended_book_id INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (recommended_book_id) REFERENCES Books(book_id)
);

-- Таблица событий корзины (CartEvents)
CREATE TABLE CartEvents (
    event_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    event_type NVARCHAR(50),
    event_time DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Таблица отчетов о продажах (SalesReports)
CREATE TABLE SalesReports (
    report_id INT PRIMARY KEY,
    report_name NVARCHAR(100),
    report_date DATE,
    sales_amount DECIMAL(15, 2)
);

-- Добавление внешних ключей для Books
ALTER TABLE Books
ADD CONSTRAINT FK_Books_Authors FOREIGN KEY (author_id) REFERENCES Authors(author_id);

-- Добавление внешних ключей для Books
ALTER TABLE Books
ADD CONSTRAINT FK_Books_Genres FOREIGN KEY (genre_id) REFERENCES Genres(genre_id);

-- Добавление внешних ключей для SalesReports
ALTER TABLE SalesReports
ADD CONSTRAINT FK_SalesReports_Books FOREIGN KEY (report_id) REFERENCES Books(book_id);

-- Добавление внешних ключей для Genres
ALTER TABLE Genres
ADD CONSTRAINT FK_Genres_Books FOREIGN KEY (genre_id) REFERENCES Books(book_id);

-- Добавление внешних ключей для Discounts
ALTER TABLE Discounts
ADD CONSTRAINT FK_Discounts_Books FOREIGN KEY (discount_id) REFERENCES Books(book_id);

-- Добавление внешних ключей для Authors
ALTER TABLE Authors
ADD CONSTRAINT FK_Authors_Books FOREIGN KEY (author_id) REFERENCES Books(book_id);

-- Добавление внешних ключей для Admins
ALTER TABLE Admins
ADD CONSTRAINT FK_Admins_Books FOREIGN KEY (admin_id) REFERENCES Books(book_id);

-- Триггеры
-- Триггер для проверки аномалий даты заказа
CREATE TRIGGER CheckOrderDate
ON Orders
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE order_date > GETDATE() -- Условие для проверки даты
    )
    BEGIN
        RAISERROR ('Недопустимая дата заказа.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

-- Триггер для проверки уникальности покупателя по email адресу
CREATE TRIGGER CheckCustomerEmail
ON Customers
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT email, COUNT(*)
        FROM inserted
        GROUP BY email
        HAVING COUNT(*) > 1 -- Проверка уникальности email адреса
    )
    BEGIN
        RAISERROR ('Покупатель с таким email уже существует.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

-- Триггер для каскадного удаления книг указанного автора при удалении автора
CREATE TRIGGER CascadeDeleteAuthorBooks
ON Authors
AFTER DELETE
AS
BEGIN
    DELETE FROM Books WHERE author_id IN (SELECT deleted.author_id FROM deleted)
END;

-- Триггер для запрета добавления одной и той же книги в избранное несколько раз
CREATE TRIGGER PreventDuplicateWishlist
ON Wishlist
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT book_id, customer_id, COUNT(*)
        FROM inserted
        GROUP BY book_id, customer_id
        HAVING COUNT(*) > 1 -- Проверка на дубликаты в избранном
    )
    BEGIN
        RAISERROR ('Книга уже есть в избранном.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

-- Представления
-- Представление для получения книг и их авторов
CREATE VIEW BooksAndAuthors AS
SELECT b.book_id, b.title, b.price, b.publication_date, b.description, a.author_name
FROM Books b
JOIN Authors a ON b.author_id = a.author_id;

-- Представление для получения информации о пользователях и их истории заказов
CREATE VIEW CustomerOrderHistory AS
SELECT c.customer_id, c.customer_name, c.email, o.order_id, o.order_date, o.total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Представление для получения информации об издательствах и их книгах
CREATE VIEW PublishersAndBooks AS
SELECT p.publisher_id, p.publisher_name, p.headquarters_location, b.title
FROM Publishers p
LEFT JOIN Book_Publisher_Link bpl ON p.publisher_id = bpl.publisher_id
LEFT JOIN Books b ON bpl.book_id = b.book_id;