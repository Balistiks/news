const Models = require('../models');
var bodyParser = require('body-parser');

exports.getNews = async function(req, res) {
    Models.newsModel.findAll().then(data => {
        res.json(data);
    })
}

exports.postNews = async function(req, res) {
    const news = await Models.newsModel.create({
        'title': req.body.title,
        'text': req.body.text
    })

    res.json(news);
}

exports.getOneNews = async function(req, res) {
    const news = await Models.newsModel.findOne({
        where: {
            id: req.params.id
        }
    });

    res.json(news);
}

exports.deleteNews = async function(req, res) {
    const data = await Models.newsModel.destroy({
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
    console.log(data);
    console.log(req.params);

    const news = await Models.newsModel.findOne({
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
