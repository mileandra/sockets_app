export default {
  answer: state => {
    return (taskId) => {
      let answer = state.answers.find((answer) => answer.task_id == taskId)
      return answer
    }
  }
}