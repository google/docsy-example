function renderQuiz(containerId, quiz) {
  const container = document.getElementById(containerId);
  console.log("container: ", container)
  if (!container) return;
  let current = 0;
  let score = 0;

  function showQuestion(idx) {
    const q = quiz[idx];
    container.innerHTML = `
      <div class="quiz-question">${q.question}</div>
      <div class="quiz-options">
        ${q.options.map((opt, i) => `<button class='quiz-option' data-idx='${i}'>${opt}</button>`).join('')}
      </div>
      <div class="quiz-feedback"></div>
    `;
    container.querySelectorAll('.quiz-option').forEach(btn => {
      btn.onclick = function() {
        const selected = parseInt(this.getAttribute('data-idx'));
        const feedback = container.querySelector('.quiz-feedback');
        if (selected === q.answer) {
          score++;
          feedback.textContent = 'נכון!';
        } else {
          feedback.textContent = 'טעות';
        }
        setTimeout(() => {
          if (idx + 1 < quiz.length) {
            showQuestion(idx + 1);
          } else {
            showResults();
          }
        }, 800);
      };
    });
  }

  function showResults() {
    let resultsHTML = `<div class='quiz-result'>תמו השאלות, התוצאה שלך: ${score}/${quiz.length}</div>`;
    resultsHTML += `<div class='quiz-review'><h3>סיכום השאלות והתשובות הנכונות:</h3>`;
    
    quiz.forEach((q, index) => {
      resultsHTML += `
        <div class='quiz-review-item'>
          <div class='quiz-review-question'><strong>שאלה ${index + 1}:</strong> ${q.question}</div>
          <div class='quiz-review-answer'><strong>התשובה הנכונה:</strong> ${q.options[q.answer]}</div>
        </div>
        <br>
      `;
    });
    
    resultsHTML += `</div>`;
    container.innerHTML = resultsHTML;
  }

  showQuestion(current);
}
// To use: renderQuiz('quiz-container', quizData); 