const { sequelize, News, File } = require('../models');
var bodyParser = require('body-parser');

exports.getNews = async function(req, res) {
    News.findAll({
        include: File
    }).then(data => {
        res.json(data);
    })
}

exports.postNews = async function(req, res) {
    const news = await News.create({
        'title': req.body.title,
        'text': req.body.text
    })

    res.json(news);
}

exports.getOneNews = async function(req, res) {
    const news = await News.findOne({
        where: {
            id: req.params.id
        },
        include: File
    });

    res.json(news);
}

exports.deleteNews = async function(req, res) {
    const data = await News.destroy({
        where: {
            id: req.params.id
        }
    });
    if (data == 1) {
        res.sendStatus(204);
    } else {
        res.sendStatus(500);
    }
}

exports.updateNews = async function(req, res) {
    const data = req.body;

    const news = await News.findOne({
        where: {
            id: req.params.id
        }
    })
    for (var key in data) {
        console.log(data[key])
        news[key] = data[key]
    }
    news.save();
    res.json(news);
}
