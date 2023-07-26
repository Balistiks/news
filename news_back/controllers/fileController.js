const Models = require('../models');
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

    const path = 'news_files/' + hex;

    if (!fs.existsSync(path)) 
        fs.writeFileSync(path, new DataView(data.buffer, data.byteOffset, data.byteLength));

    const json = {
        path: path,
        sha512hash: hex,
        newsId: req.body.newsId
    }

    await Models.File.create(json);

    res.json({
        'link': '0.0.0.0:3002/file/get?id=' + hex,
    });
}