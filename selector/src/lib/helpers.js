const bcrypt = require('bcryptjs');
const helpers = {};
const faker = require('faker');

helpers.encryptPassword = async (password) => {
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(password, salt);
    return hash;
};

helpers.matchPassword = async (password, savedPassword) => {
    try {
        return await bcrypt.compare(password, savedPassword);
    } catch (e) {
        console.log(e);
    }
};


helpers.fakeUser = (locale) => {
    faker.locale = locale;
    const fakeUser = {
        nome: faker.name.findName(),
        email: faker.internet.email(),
        senha: '1234567890'
//        website: faker.internet.url(),
//        address: faker.address.streetAddress() + faker.address.city() + faker.address.country(),
//        bio: faker.lorem.sentences(),
//        image: faker.image.avatar()
    }
    return fakeUser;
}

/*
helpers.isAdm = (adm) => {
    return adm === 'Y';
};
*/




module.exports = helpers;