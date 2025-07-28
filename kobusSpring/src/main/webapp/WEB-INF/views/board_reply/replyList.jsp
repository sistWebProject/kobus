<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 댓글 CSS 적용  -->
<style>
.comment-write {
	margin-top: 30px;
	padding: 16px;
	background-color: #f9f9f9;
	border: 1px solid #ccc;
	border-radius: 8px;
}

.comment-write textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	resize: vertical;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-family: inherit;
	font-size: 14px;
}

.comment-write button {
	margin-top: 10px;
	padding: 8px 16px;
	background-color: #114397;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.comment-write button:hover {
	background-color: #0d356f;
}

.comment-item {
	padding: 10px 12px;
	border-bottom: 1px solid #ddd;
	font-size: 14px;
	position: relative;
}

.comment-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.comment-user {
	font-weight: bold;
	color: #114397;
}

.comment-content {
	margin-left: 5px;
	flex: 1;
	word-break: break-word;
}

.comment-date {
	font-size: 12px;
	color: #888;
	white-space: nowrap;
	margin-left: 10px;
}

.comment-content-edit {
	width: 100%;
	min-height: 40px;
	resize: none;
	overflow: auto;
	font-size: 14px;
	padding: 6px 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	line-height: 1.4;
	box-sizing: border-box;
	background-color: #fff;
	color: #222;
	font-family: inherit;
}
</style>

<c:forEach var="comment" items="${comments}">
    <div class="comment-item" id="comment-${comment.bcmID}">
        <div class="comment-header">
            <span class="comment-user">${comment.kusID}</span>
            <span class="comment-date">
                <fmt:formatDate value="${comment.cmtDate}" pattern="yyyy-MM-dd HH:mm" />
            </span>
        </div>

        <div class="comment-content" id="content-${comment.bcmID}">
            ${comment.content}
        </div>

        <div class="comment-edit-area" id="edit-area-${comment.bcmID}" style="display:none;">
            <form onsubmit="return submitEdit(${comment.bcmID});">
                <textarea id="editTextarea-${comment.bcmID}" rows="3" style="width:100%;">${comment.content}</textarea>
                <br>
                <button type="submit">수정 완료</button>
                <button type="button" onclick="cancelEdit(${comment.bcmID});">취소</button>
            </form>
        </div>

        <c:if test="${sessionScope.auth eq comment.kusID}">
            <div class="comment-actions">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <button onclick="showEditForm(${comment.bcmID})">수정</button>
                <button onclick="deleteReply(${comment.bcmID})">삭제</button>
            </div>
        </c:if>
    </div>
</c:forEach>

<script>
function showEditForm(bcmID) {
    document.getElementById("content-" + bcmID).style.display = "none";
    document.getElementById("edit-area-" + bcmID).style.display = "block";
}

function cancelEdit(bcmID) {
    document.getElementById("edit-area-" + bcmID).style.display = "none";
    document.getElementById("content-" + bcmID).style.display = "block";
}

function submitEdit(bcmID) {
    const newContent = document.getElementById("editTextarea-" + bcmID).value;

    fetch("replyEdit.do", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "bcmID=" + bcmID + "&content=" + encodeURIComponent(newContent)
    })
    .then(res => res.text())
    .then(result => {
        if (result.trim() === "success") {
            loadComments();
        } else {
            alert("댓글 수정 실패");
        }
    });

    return false;
}

function deleteReply(bcmID) {
    if (!confirm("댓글을 삭제하시겠습니까?")) return;

    fetch("replyDelete.do", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "bcmID=" + bcmID
    })
    .then(res => res.text())
    .then(result => {
        if (result.trim() === "success") {
            loadComments();
        } else if (result.trim() === "nologin") {
            alert("로그인이 필요합니다.");
            location.href = '${pageContext.request.contextPath}/page/logonMain.do';
        } else {
            alert("댓글 삭제 실패");
        }
    });
}
</script>
