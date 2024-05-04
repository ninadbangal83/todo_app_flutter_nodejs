const mongoose = require("mongoose");

const taskSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
    trim: true,
  },  
  description: {
    type: String,
    required: true,
    trim: true,
  },
  completed: {
    type: Boolean,
    required: false,
    default: false,
  },
  owner: {
    type:mongoose.Schema.Types.ObjectId,
    require: true,
    ref: 'User'

  }
}, {timestamps: true,
  toJSON: {virtuals: true}
})

const Task = mongoose.model("Task", taskSchema);

module.exports = Task;
