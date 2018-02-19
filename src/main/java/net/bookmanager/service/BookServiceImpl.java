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

    @Override
    @Transactional
    public List<Book> listBooksWithTitle(String title) {
        List<Book> list = new ArrayList<Book>();
        for (Book book : bookDao.listBooks()) {
            if (book.getTitle().contains(title))
                list.add(book);
        }

        return list;
    }

    @Override
    @Transactional
    public List<Book> allNotReadBook(List<Book> list) {
        List<Book> res = new ArrayList<>();
        for (Book book : list)
            if (!book.isReadAlready()) res.add(book);
        return res;
    }

    @Override
    @Transactional
    public List<Book> pageListBooks(int page, String searchName, boolean isNotReadAlready) {

        List<Book> list1;
        if (searchName != null) list1 = listBooksWithTitle(searchName);
        else list1 = bookDao.listBooks();

        List<Book> list = new ArrayList<>();
        if (isNotReadAlready) {
            list = allNotReadBook(list);
        } else list.addAll(list1);
        if (list.size() > MAXLINES)
            if (MAXLINES * page < list.size()) return list.subList(MAXLINES * (page - 1), MAXLINES * page);
            else return list.subList(MAXLINES * (page - 1), list.size());

        return list;
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
