package net.bookmanager.service;

import net.bookmanager.model.Book;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface BookService {
    int MAXLINES = 10;

    void addBook(Book book);

    void updateBook(Book book);

    void removeBook(int id);

    @Transactional
    void isReadAlready(int id);


    @Transactional
    List<Book> listBooksWithTitle(String name);


    @Transactional
    List<Book> allNotReadBook(List<Book> list);

    @Transactional
    List<Book> pageListBooks(int page, String searchName, boolean isNotReadAlready);

    Book getBookById(int id);

    List<Book> listBooks();
}
