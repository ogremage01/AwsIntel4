package com.edu.util;

import java.io.Serializable;

public class Paging implements Serializable{
	// 페이지당 게시물 수
	public static final int PAGE_SCALE = 6;
	// 화면당 블럭 수
	public static final int BLOCK_SCALE = 3;
	
	private int curPage;
	
	private int totPage;
	private int totBlock;
	
	private int curBlock;
	
	private int prevBlock;
	private int nextBlock;
	
	private int pageBegin;
	private int pageEnd;
	
	private int blockBegin;
	private int blockEnd;
	
	public Paging(int count, int curPage) {
		this.curPage = 1;
		
		setTotPage(count);
		
		if(curPage > totPage) {
			curPage = totPage;
		}
		
		this.curPage = curPage;
		
		setPageRange();
		setTotBlock();
		setBlockRange();
	}
	
	public int getTotPage() {
		return totPage;
	}
	
	public void setTotPage(int count) {
		this.totPage = (int)Math.ceil(count * 1.0 / PAGE_SCALE);
	}
	
	public void setPageRange() {
		pageBegin = (curPage - 1) * PAGE_SCALE + 1;
		pageEnd = pageBegin + PAGE_SCALE - 1;
	}
	
	public void setTotBlock() {
		this.totBlock = (int)Math.ceil((double)totPage / (double)BLOCK_SCALE);
	}
	
	public void setBlockRange() {
		curBlock = (int)Math.ceil((curPage - 1) / BLOCK_SCALE) + 1;
		
		blockBegin = (curBlock - 1) * BLOCK_SCALE + 1;
		
		blockEnd = blockBegin + BLOCK_SCALE - 1;
		
		if(blockEnd > totPage) {
			blockEnd = totPage;
		}
		
		prevBlock = (curPage == 1) ? 1 : (curBlock - 1) * BLOCK_SCALE;
		
		nextBlock = curBlock > totBlock ? (curBlock * BLOCK_SCALE)
			: (curBlock * BLOCK_SCALE) + 1;
		
		if(prevBlock <= 0) {
			prevBlock = 1;
		}
		
		if(nextBlock >= totPage) {
			nextBlock = totPage;
		}
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getTotBlock() {
		return totBlock;
	}

	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	
	
	
}
