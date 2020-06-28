DROP TABLE IF EXISTS ProductCategories;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Images;
DROP TABLE IF EXISTS ItemsBought;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;


CREATE TABLE Product (
  id          INTEGER NOT NULL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  description VARCHAR(500) NULL,
  size        VARCHAR(100) NOT NULL,
  colour      VARCHAR(100) NULL,
  stock       INTEGER NOT NULL,
  price       DECIMAL(9,2) NOT NULL
);

CREATE TABLE Customer (
    email       VARCHAR(100) NOT NULL PRIMARY KEY,
    password    VARCHAR(100) NOT NULL,
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(12) NOT NULL UNIQUE,
    address     VARCHAR(100) NOT NULL
);

CREATE TABLE Purchase (
    id          INTEGER NOT NULL PRIMARY KEY,
    email       VARCHAR(100) NOT NULL,
    discount    DECIMAL(5,2) NOT NULL,
    total_price DECIMAL(9,2) NOT NULL,
    time_placed DATETIME NOT NULL,
    CONSTRAINT Purchase_Customer_FK FOREIGN KEY (email) REFERENCES
    Customer(email),
    CONSTRAINT Check_Discount CHECK (discount>=0 AND discount<=100)
);

CREATE TABLE ItemsBought (
    purchase_id INTEGER NOT NULL,
    product_id  INTEGER NOT NULL,
    quantity    INTEGER NOT NULL,
    CONSTRAINT ItemsBought_Purchase_FK FOREIGN KEY (purchase_id) REFERENCES
    Purchase(id),
    CONSTRAINT ItemsBought_Product_FK FOREIGN KEY (product_id) REFERENCES
    Product(id)
);

CREATE TABLE Images (
    id          INTEGER NOT NULL PRIMARY KEY,
    product_id  INTEGER NULL,
    url         VARCHAR(100) NOT NULL,
    CONSTRAINT Images_Product_FK FOREIGN KEY (product_id) REFERENCES
    Product(id)
);

CREATE TABLE Category (
    id          INTEGER NOT NULL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(500) NULL
);

CREATE TABLE ProductCategories (
    category_id INTEGER NOT NULL,
    product_id  INTEGER NOT NULL,
    CONSTRAINT  ProductCategories_Category_FK FOREIGN KEY (category_id) REFERENCES
    Category(id),
    CONSTRAINT  ProductCategories_Product_FK FOREIGN KEY (product_id) REFERENCES
    Product(id)
);
