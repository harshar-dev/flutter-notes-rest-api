const express = require("express");
const mongoose = require("mongoose");
const noteSchema = require("./models/noteSchema");
const jwt = require('jsonwebtoken');
const userSchema = require("./models/userSchema");
const bcrypt = require('bcrypt');

const app = express();


app.use(express.json());


mongoose.connect('mongodb://127.0.0.1:27017/notes_app')
    .then(() => { console.log("mongodb connect successfully") })
    .catch((err) => console.log(err))

app.listen(3000, () => {
    console.log("server is listening on port 3000")
});




app.post('/api/add_notes', async (req, res) => {

    const bearertoken = req.headers.authorization;

    const realtoken = bearertoken.split(" ")[1];


    const decoded = await jwt.verify(
        realtoken,
        'SECRET_KEY'
    )

    try {
        const body = req.body;
        await noteSchema.create({
            'title': body['title'],
            'incidents': body['incidents'],
            'createdAt': body['createdAt'],
            'userId': decoded.id
        });

        return res.status(201).json({
            message: "Note created Succesfully"
        })
    } catch (error) {
        return res.status(500).json({
            message: 'server error'
        })
    }

});



app.get('/api/get_notes', async (req, res) => {
    const bearertoken = req.headers.authorization;

    const realtoken = bearertoken.split(" ")[1];


    const decoded = await jwt.verify(
        realtoken,
        'SECRET_KEY'
    )
    try {
        const data = await noteSchema.find({
            'userId': decoded.id
        });
        res.status(200).json(data);
    } catch (error) {
        return res.status(500).json({
            message: 'server error'
        })
    }

});




app.get('/api/get_notes_bysearch', async (req, res) => {
    const searchtext = req.query.name;
    const bearertoken = req.headers.authorization;

    const realtoken = bearertoken.split(" ")[1];


    const decoded = await jwt.verify(
        realtoken,
        'SECRET_KEY'
    );

    try {
        const searchdata = await noteSchema.find({
            'title': {

                $regex: searchtext,
                $options: "i"
            },
            'userId': decoded.id,

        });

        res.status(200).json(searchdata);
    } catch (error) {
        return res.status(500).json({
            message: 'server error'
        })
    }

});


app.delete('/api/delete_note/:id', async (req, res) => {
    const bearertoken = req.headers.authorization;

    const realtoken = bearertoken.split(" ")[1];


    const decoded = await jwt.verify(
        realtoken,
        'SECRET_KEY'
    );


    try {
        const deletedNote = await noteSchema.findOneAndDelete({
            '_id': req.params.id,
            userId: decoded.id
        })

        if (!deletedNote) {
            return res.status(404).json({
                message: "Note not found"
            });
        }

        res.status(200).json({
            message: 'delete successfully'
        })

    } catch (error) {
        return res.status(500).json({
            message: 'server error'
        })
    }


});


app.put('/api/edit_note/:id', async (req, res) => {
    const body = req.body;
    const bearertoken = req.headers.authorization;

    const realtoken = bearertoken.split(" ")[1];


    const decoded = await jwt.verify(
        realtoken,
        'SECRET_KEY'
    );


    try {
        const updatedNote = await noteSchema.findOneAndUpdate(
            {
                '_id': req.params.id,
                userId: decoded.id
            },
            {
                'title': body['title'],
                'incidents': body['incidents'],
                'createdAt': body['createdAt']
            })
        if (!updatedNote) {
            return res.status(404).json({
                message: "Note not found"
            });
        }

        res.status(200).json({
            message: 'sucsessfully edited data'
        })
    } catch (error) {
        return res.status(500).json({
            message: 'server error'
        })
    }


});




app.post('/api/signup', async (req, res) => {
    const body = req.body;
    const hashedpassword = await bcrypt.hash(body['password'], 10);



    const user = await userSchema.create({
        'name': body['name'],
        'email': body['email'],
        'password': hashedpassword,
        'createdAt': body['createdAt']
    });

    const tokengenerate = await jwt.sign(
        {
            'id': user._id
        },
        'SECRET_KEY',
        {
            expiresIn: '7d'
        }
    )

    res.status(201).json({
        'token': tokengenerate,
        'message': 'succesfully signed in'
    });

});




app.post('/api/login', async (req, res) => {
    const body = req.body;

    const user = await userSchema.findOne({
        'email': body['email'],
    })

    if (!user) {
        return "email invalid";
    }
    const comparepassword = await bcrypt.compare(body['password'], user.password);

    if (!comparepassword) {
        return "password incorrect";
    }

    const tokengenerate = await jwt.sign(
        {
            'id': user._id
        },
        'SECRET_KEY',
        {
            'expiresIn': '7d'
        }
    );

    res.status(200).json({
        'token': tokengenerate,
        'message': 'succefully loged in'
    })
});


