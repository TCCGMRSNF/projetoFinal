const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');


router.get('/add', isLoggedIn, (req, res) => {
    res.render('links/add');
});

router.post('/add', isLoggedIn, async (req, res) => {
    const { title, url, description } = req.body;
    const newLink = {
        title,
        url,
        description,
        usr_id: req.user.id
    };
    await pool.query('INSERT INTO links SET ?', [newLink]);
    console.log(newLink);
    req.flash('success', 'Link foi adicinado com sucesso!');
    res.redirect('/links');
});

router.get('/', isLoggedIn, async (req, res) => {
    const links = await pool.query('SELECT * FROM links WHERE usr_id = ?', [req.user.id]);
    console.log(links);
    res.render('links/list', { links });
});

router.get('/delete/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM links WHERE id = ?', [id]);
    req.flash('success', 'Link foi excluído com sucesso!');
    res.redirect('/links');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const links = await pool.query('SELECT * FROM links WHERE id = ?', [id]);
    console.log(links[0]);
    res.render('links/edit', {link: links[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const { title, url, description } = req.body;
    const editedLink = {
        title,
        url,
        description
    };
//    console.log(id);
//    console.log(editedLink);
    await pool.query('UPDATE links SET ? WHERE id = ?', [editedLink, id]);
    req.flash('success', 'Link foi editado com sucesso!');
    res.redirect('/links');
});








// Criado por SNF
router.get('/grid', async (req, res) => {
    const links = await pool.query('SELECT * FROM links');
    //console.log(links);
    res.render('links/list_grid', { links });
});

module.exports = router;
