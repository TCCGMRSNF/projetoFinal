const dt = new Date();

const dtf = Intl.DateTimeFormat('pt-BR').format(dt);
console.log(dtf);

const dateFormatterAT = new Intl.DateTimeFormat("de-AT");
const format = dateFormatterAT.format(dt); // "25.11.2018"
console.log(format);

console.log('Puro: '+ dt);
console.log('toString: '+ dt.toString());
console.log(dt.toISOString());
console.log(dt.toLocaleString());
console.log('US ' + dt.toLocaleDateString('de-AT'));
console.log('GB ' + dt.toLocaleString('en-GB'));

var d = new Date('2013-03-10T02:00:00Z');
var fd = d.toLocaleDateString() + ' ' + d.toTimeString().substring(0, d.toTimeString().indexOf("GMT"));
console.log(d, fd);


const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
console.log(dt.toLocaleDateString('de-AT', options));


let numero = 123321.23;
let formato = { minimumFractionDigits: 2 , style: 'currency', currency: 'BRL' };
let moeda = numero .toLocaleString('pt-BR', formato);
console.log(moeda);

console.log(dt.toLocaleString().split(' ')[1]);




