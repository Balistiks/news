const { sequelize, File } = require('../models');
const crypto = require('crypto');
const fs = require('fs');

function hash(data) {
    const s = crypto.createHash('sha512');
    s.update(Buffer.from(data));
    s.end();
    return s;
}

exports.uploadFile = async function(req, res) {
    const data = new Uint8Array(req.body.file);
    const sha512 = hash(req.body.file)
    const hex = sha512.digest().toString('hex');
    console.log('aaaa')
    const path = 'news_files/' + hex;

    if (!fs.existsSync(path)) 
        fs.writeFileSync(path, new DataView(data.buffer, data.byteOffset, data.byteLength));
    console.log('fff')

    const json = {
        path: path,
        sha512hash: hex,
        newsId: req.body.newsId
    }

    await File.create(json);

    res.json({
        'link': '0.0.0.0:3002/file/get?id=' + hex,
    });
}

exports.getFile = async function(req, res) {
    const data = await File.findOne({
        where: {
            sha512hash: req.query.id
        }
    });
    if (!data) {
        return res.status(404).send('<h1>404 Not found</h1>');
    }

    try {
        const fdata = fs.readFileSync(data.path);
        const h = hash(fdata).digest().toString('hex');
        if (h == data.sha512hash) {
            return (
                res
                    // in case if some smart ass gets access to db
                    // and sets size to a small amount to get more space
                    .send(fdata.subarray())
                );
        }
        return res.status(500).send('<h1>500 Internal Server Error</h1><p>Details: file corrupt</p>');
    } catch (err) {
        return res.status(500).send('<h1>500 Internal Server Error</h1><p>Details: server error</p>');
    }
}