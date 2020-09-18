// Global Import
const cors = require('cors');
const xss = require('xss-clean');
const morgan = require('morgan');
const helmet = require('helmet');
const express = require('express');
const compression = require('compression');
const mongoSanitize = require('express-mongo-sanitize');

// Local Import
const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/errorController');

//Import Routes
const userRouter = require('./routes/userRouter');
const shopRouter = require('./routes/shopRouter');

const app = express();

app.enable('trust proxy');

//Middleware
//Implement cors
app.use(cors());
app.options('*', cors());

//set security HTTPS headers
app.use(helmet());

//Body parsser, reading  data from body into req.body
app.use(express.json({ limit: '1024kb' }));
app.use(express.urlencoded({ extended: true, limit: '1024kb' }));

// Data sanitization against NoSql query injection
app.use(mongoSanitize());

// Data sanitization against XSS
app.use(xss());

// Compress the Output
app.use(compression());

// Logging Middleware
app.use(morgan('dev'));

// ROUTES
app.use('/api/v1/user', userRouter);
app.use('/api/v1/shop', shopRouter);

//Handling unexpected routes
app.all('*', (req, res, next) => {
	next(new AppError(`Can't find ${req.originalUrl} on this server`, 500));
});

//Error handing in one central place
app.use(globalErrorHandler);

module.exports = app;
