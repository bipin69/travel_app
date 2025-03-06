// const joi = require("joi");


// const customerSchema = joi.object({
//     email: joi.string().required().email(),
//     contact_no: joi.string().required()
// })


// function CustomerValidation(req, res, next) {
//     const { email, contact_no } = req.body;
//     const { error } = customerSchema.validate({ email, contact_no })
//     if (error) {
//         return res.json(error)
//     }
//     next()
// }


// module.exports = CustomerValidation;