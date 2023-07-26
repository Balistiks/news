'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class News extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.hasOne(models.File, { foreignKey: 'newsId', onDelete: 'cascade' })
    }
  }
  News.init({
    title: DataTypes.STRING,
    text: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'News',
  });
  return News;
};