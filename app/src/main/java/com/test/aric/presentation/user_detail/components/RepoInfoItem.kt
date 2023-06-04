package com.test.aric.presentation.user_detail.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.Divider
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ChainStyle
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.constraintlayout.compose.Dimension
import coil.compose.AsyncImage
import com.test.aric.data.remote.dto.RepoInfo

@Composable
fun RepoInfoItem(
    repoInfo: RepoInfo,
) {
    ConstraintLayout(modifier = Modifier
        .height(64.dp)
        .fillMaxWidth()) {
        val (avatar, login, url, score, divider,space) = remember {
            createRefs()
        }
        createVerticalChain(login,url, chainStyle = ChainStyle.Packed)

        AsyncImage(
            model = repoInfo.owner.avatar_url,
            contentDescription = null,
            modifier = Modifier
                .size(32.dp)
                .clip(CircleShape)
                .constrainAs(avatar) {
                    top.linkTo(parent.top)
                    start.linkTo(parent.start)
                    bottom.linkTo(parent.bottom)
                }
        )

        Text(
            text = "${repoInfo.owner.login}",
            fontSize = 14.sp,
            fontWeight = FontWeight.Bold,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.constrainAs(login) {
                top.linkTo(avatar.top)
                start.linkTo(avatar.end, margin = 8.dp)
                end.linkTo(score.start)
                width = Dimension.preferredWrapContent
                bottom.linkTo(url.top)
            }
        )

        Text(
            text = repoInfo.owner.id.toString(),
            fontSize = 10.sp,
            textAlign = TextAlign.Center,
            modifier = Modifier.constrainAs(score) {
                top.linkTo(login.top)
                start.linkTo(login.end, margin = 6.dp)
                end.linkTo(space.start)
                bottom.linkTo(login.bottom)
                width = Dimension.wrapContent
            }
        )

        Spacer(modifier =Modifier.background(Color.White).constrainAs(space){
            width = Dimension.fillToConstraints
            top.linkTo(login.top)
            bottom.linkTo(login.bottom)
            start.linkTo(score.end, margin = 6.dp)
            end.linkTo(parent.end)
        } )

        Text(
            text = repoInfo.html_url,
            fontSize = 12.sp,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.constrainAs(url) {
                top.linkTo(login.bottom)
                start.linkTo(login.start)
                end.linkTo(parent.end)
                width = Dimension.ratio("0")
                bottom.linkTo(parent.bottom)
            }
        )

        Divider(
            color = Color.LightGray,
            modifier = Modifier.constrainAs(divider) {
                start.linkTo(parent.start)
                end.linkTo(parent.end)
                bottom.linkTo(parent.bottom)
                width = Dimension.matchParent
            }
        )
    }
}
