const express = require('express');
const newsController = require('./controllers/newsController.js')
const fileController = require('./controllers/fileController.js')
var bodyParser = require('body-parser')

const app = express();

app.use(bodyParser.urlencoded({ limit: "200mb",  extended: true, parameterLimit: 3000000 }))
app.use(bodyParser.json({ limit: "200mb" }))

const newsRouter = express.Router();
const fileRouter = express.Router();

newsRouter.delete('/:id', newsController.deleteNews);
newsRouter.put('/:id', newsController.updateNews);
newsRouter.get('/:id', newsController.getOneNews);
newsRouter.post('/', newsController.postNews);
newsRouter.use('/', newsController.getNews);
app.use('/news', newsRouter);

fileRouter.post('/upload', fileController.uploadFile);
app.use('/file', fileRouter)

app.use(function (req, res, next) {
    res.status(404).send("Not Found")
});

const port = 3002;
const server = app.listen(port, (error) => {
    if (error) return console.log(`Error: ${error}`);
    console.log(`Server listening on port ${server.address().port}`);
});