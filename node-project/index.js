const express = require('express');
const redis = require('redis');

const app = express();
const db = redis.createClient()

db.set('visits', 0);

app.get('/', (req, res) => {
    db.get('visits', (err, visits) => {
        res.send('Number of visits: ' + visits);
        db.set('visits', parseInt(visits) + 1);
    });
});

app.listen('8080', () => {
    console.log('Listening on port 8080');
});
