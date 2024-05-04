// services/taskService.js

const Task = require("../models/taskModel");

const createTask = async (taskData, userId) => {
    const task = new Task({ ...taskData, owner: userId });
    await task.save();
    return task;
};

const getTasks = async (user, query) => {
    const match = {};
    const sort = {};

    if (query.completed) {
        match.completed = query.completed === "true";
    }

    if (query.sortBy) {
        const parts = query.sortBy.split(":");
        sort[parts[0]] = parts[1] === "desc" ? -1 : 1;
    }
    
    let pop = await user.populate({
        path: "tasks",
        match,
        options: {
            limit: parseInt(query.limit),
            skip: parseInt(query.skip),
            sort,
        },
    })
    return pop.tasks;
};

const getTaskById = async (taskId, userId) => {
    const task = await Task.findOne({ _id: taskId, owner: userId });
    if (!task) {
        throw new Error("Task not found");
    }
    return task;
};

const updateTask = async (taskId, updates, userId) => {
    const task = await Task.findOne({ _id: taskId, owner: userId });
    if (!task) {
        throw new Error("Task not found");
    }

    Object.keys(updates).forEach((update) => (task[update] = updates[update]));
    await task.save();
    return task;
};

const deleteTask = async (taskId, userId) => {
    const task = await Task.findOneAndDelete({ _id: taskId, owner: userId });
    if (!task) {
        throw new Error("Task not found");
    }
    return task;
};

module.exports = {
    createTask,
    getTasks,
    getTaskById,
    updateTask,
    deleteTask,
};
