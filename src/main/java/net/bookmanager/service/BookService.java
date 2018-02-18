package net.bookmanager.service;

import net.bookmanager.model.Book;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface BookService {
     static final int MAXLINES = 2   ;
    public void addBook(Book book);

    public void updateBook(Book book);

    public void removeBook(int id);

    @Transactional
    void isReadAlready(int id);


    @Transactional
    List<Book> pageListBooks(int page, String searchName);

    public Book getBookById(int id);

    public List<Book> listBooks();
}
