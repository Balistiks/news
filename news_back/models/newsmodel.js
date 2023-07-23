'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class newsModel extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  newsModel.init({
    title: DataTypes.STRING,
    text: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'newsModel',
  });
  return newsModel;
};