package net.bookmanager.dao;

import net.bookmanager.model.Book;

import java.util.List;

public interface BookDao {
    void addBook(Book book);

    void updateBook(Book book);

    void removeBook(int id);

    void isReadAlready(int id);

    Book getBookById(int id);

    List<Book> listBooks();
}
