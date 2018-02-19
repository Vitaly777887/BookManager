package net.bookmanager.controller;

import net.bookmanager.model.Book;
import net.bookmanager.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class BookController {
    private BookService bookService;

    @Autowired
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }


    @RequestMapping(value = "/books")
    public String listBooks(@RequestParam(required = false, defaultValue = "1") int page,
                            @RequestParam(required = false, defaultValue = "") String searchName,
                            @RequestParam(required = false, defaultValue = "false") boolean isNotReadAlready,
                            Model model) {
        List<Book> list = bookService.pageListBooks(page, searchName, isNotReadAlready);
        model.addAttribute("booksSearch", bookService.allNotReadBook(bookService.listBooksWithTitle(searchName)).size());
        model.addAttribute("maxPages", (int) Math.ceil(1.0 * bookService.listBooksWithTitle(searchName).size() /
                bookService.MAXLINES));
        model.addAttribute("page", page);
        model.addAttribute("book", new Book());
        model.addAttribute("listBooks", list);


        model.addAttribute("searchName", searchName);
        model.addAttribute("isNotReadAlready", isNotReadAlready);

        return "books";
    }

    @RequestMapping("/isReadAlready/{id}")
    public String isReadAlready(@PathVariable("id") int id, @RequestParam("page") int page) {

        this.bookService.isReadAlready(id);

        return "redirect:/books?page=" + page;
    }

    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book, @RequestParam("page") int page) {

        if (book.getId() == 0) {
            this.bookService.addBook(book);
        } else {
            this.bookService.updateBook(book);
        }
        return "redirect:/books?page=" + page;
    }

    @RequestMapping("/remove/{id}")
    public String removeBook(@PathVariable("id") int id, @RequestParam("page") int page) {
        this.bookService.removeBook(id);

        return "redirect:/books?page=" + page;
    }

    @RequestMapping("edit/{id}")
    public String editBook(@PathVariable("id") int id, @RequestParam("page") int page, Model model) {
        model.addAttribute("book", this.bookService.getBookById(id));
        model.addAttribute("pagesSearch", bookService.listBooks().size());
        model.addAttribute("page", page);
        model.addAttribute("listBooks", this.bookService.pageListBooks(page, "", false));

        return "books";
    }

    @RequestMapping("bookdata/{id}")
    public String bookData(@PathVariable("id") int id, Model model) {
        model.addAttribute("book", this.bookService.getBookById(id));

        return "bookdata";
    }
}