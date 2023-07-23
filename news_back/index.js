const express = require('express');
const newsController = require('./controllers/newsController.js')
var bodyParser = require('body-parser')

const app = express();

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

const newsRouter = express.Router();

newsRouter.delete('/:id', newsController.deleteNews);
newsRouter.put('/:id', newsController.updateNews);
newsRouter.get('/:id', newsController.getOneNews);
newsRouter.post('/', newsController.postNews);
newsRouter.use('/', newsController.getNews);
app.use('/news', newsRouter);

app.use(function (req, res, next) {
    res.status(404).send("Not Found")
});

const port = 3002;
const server = app.listen(port, (error) => {
    if (error) return console.log(`Error: ${error}`);
    console.log(`Server listening on port ${server.address().port}`);
});