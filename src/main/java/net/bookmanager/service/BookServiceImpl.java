package net.bookmanager.service;

import net.bookmanager.dao.BookDao;
import net.bookmanager.model.Book;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    private BookDao bookDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    @Transactional
    public void addBook(Book book) {
        this.bookDao.addBook(book);
    }

    @Override
    @Transactional
    public void updateBook(Book book) {
        this.bookDao.updateBook(book);

    }

    @Override
    @Transactional
    public void removeBook(int id) {
        this.bookDao.removeBook(id);
    }
    @Override
    @Transactional
    public void isReadAlready(int id) {
        this.bookDao.isReadAlready(id);
    }

    @Transactional
    public List<Book> currentListBooks(String name) {
        List<Book> list =new ArrayList<Book>();
        for (Book book :bookDao.listBooks()) {
            if (book.getDescription().contains(name))
                list.add(book);
        }

        return list;
    }

    @Override
    @Transactional
    public List<Book> pageListBooks(int page, String searchName) {

        List<Book> list ;
        if(searchName!=null) list=currentListBooks(searchName);

        else list =bookDao.listBooks();
        return list.subList(MAXLINES*(page-1),MAXLINES*page);
    }

    @Override
    @Transactional
    public Book getBookById(int id) {
        return this.bookDao.getBookById(id);
    }


    @Override
    @Transactional
    public List<Book> listBooks() {
        return this.bookDao.listBooks();
    }
}
