<template>
<div class="col-lg-6" style="margin-top:20px">
	<div class="card shadow">
		<div class="card-body">
			<h4 class="card-title">{{server_data2.board_info_name}}</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center w-25">글번호</th>
						<th>제목</th>
						<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for='obj in server_data' :key='obj'>
						<td class="text-center">{{obj.RowNum}}</td>
						<td  @click='go_board_read(obj.content_idx)'>{{obj.content_subject}}</td>
						<td class="text-center d-none d-xl-table-cell">{{obj.content_date}}</td>
					</tr>
				</tbody>
			</table>
			
			<router-link :to="'/board_main/' + board_idx + '/1'" class="btn btn-primary">더보기</router-link>
		</div>
	</div>
</div>
</template>
<style>
	#board_list > tbody > tr {
		cursor: pointer;
	}
</style>
<script>
	module.exports = {
		data : function(){
			return {
				temp_list : [1, 2, 3, 4, 5],
				server_data : {},
				server_data2 : {}
			}
		},
		props : ['board_idx'],
		methods : {
			go_board_read : function(content_idx){
				this.$router.push('/board_read/' + this.board_idx + '/1/' + content_idx)
			}
		},
		created () {
			var params = new URLSearchParams()
			params.append('board_idx', this.board_idx)
			
			axios.post('server/board/get_board_title.asp', params).then((response) => {
				console.log(response.data)
				//alert(response.data)
				this.server_data2 = response.data[0]
			}),

			axios.post('server/board/get_top5_list.asp', params).then((response) => {
				console.log(response.data)
				this.server_data = response.data
			})
		},

	}
</script>