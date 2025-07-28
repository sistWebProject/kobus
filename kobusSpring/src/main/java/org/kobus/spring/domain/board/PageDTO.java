package org.kobus.spring.domain.board;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageDTO {
    private Criteria cri;
    private int totalCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;

    public PageDTO(Criteria cri, int totalCount) {
        this.cri = cri;
        this.totalCount = totalCount;

        int displayPageNum = 10;
        this.endPage = (int)(Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
        this.startPage = this.endPage - displayPageNum + 1;
        int tempEnd = (int)(Math.ceil(totalCount / (double) cri.getPerPageNum()));
        if (endPage > tempEnd) endPage = tempEnd;

        this.prev = startPage > 1;
        this.next = endPage * cri.getPerPageNum() < totalCount;
    }

    public Criteria getCri() { return cri; }
    public int getStartPage() { return startPage; }
    public int getEndPage() { return endPage; }
    public boolean isPrev() { return prev; }
    public boolean isNext() { return next; }
}