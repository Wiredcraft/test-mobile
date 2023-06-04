package com.test.aric.presentation.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.rememberScrollableState
import androidx.compose.foundation.gestures.scrollable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Divider
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ChainStyle
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.constraintlayout.compose.Dimension
import coil.compose.AsyncImage
import com.test.aric.R

@Preview
@Composable
fun GithubCommonListItemPreview() {
    GithubCommonListItem(
        "wwww.baidu.com",
        "GithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItemGithubCommonListItem",
        "109.0",
        "www.babaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaidubaiduidu.com",
        123,
        "关注",
        {},
        {},
        true
    )
}


@Composable
fun ScrollableSample() {
    var offset by remember { mutableStateOf(0f) }
    Box(
        Modifier
            .size(150.dp)
            .scrollable(orientation = Orientation.Vertical,
                // Scrollable state: describes how to consume
                // scrolling delta and update offset
                state = rememberScrollableState { delta ->
                    offset += delta
                    delta
                })
            .background(Color.LightGray), contentAlignment = Alignment.Center
    ) {
        Text(offset.toString())
    }
}

@Composable
fun nestedScroll() {
    val gradient = Brush.verticalGradient(0f to Color.Gray, 1000f to Color.White)
    Box(
        modifier = Modifier
            .background(Color.LightGray)
            .verticalScroll(rememberScrollState())
            .padding(32.dp)
    ) {
        Column {
            repeat(6) {
                Box(
                    modifier = Modifier
                        .height(128.dp)
                        .verticalScroll(rememberScrollState())
                ) {
                    Text(
                        "Scroll here",
                        modifier = Modifier
                            .border(12.dp, Color.DarkGray)
                            .background(brush = gradient)
                            .padding(24.dp)
                            .height(150.dp)
                    )
                }
            }
        }
    }

}

@Preview
@Composable
fun SearchBarPreview() {
    SearchBar("swift") {}
}

@Composable
fun SearchBar(textValue: String, onClick: (String) -> Unit) {
    var text by remember { mutableStateOf(textValue) }
    BasicTextField(
        value = text,
        onValueChange = {
            text = it
        },
        singleLine = true,
        decorationBox = { innerTextField ->
            Row(verticalAlignment = Alignment.CenterVertically) {
                Box(Modifier.weight(1f)) {
                    innerTextField()
                }
                IconButton(onClick = {
                    onClick(text)
                }) {
                    Icon(
                        painterResource(id = R.drawable.ic_search),
                        null,
                        tint = Color(0xFFBFBFBF)
                    )
                }
            }
        },
        modifier = Modifier
            .fillMaxWidth()
            .height(30.dp)
            .background(color = Color(0xFFF5F5F5), shape = RoundedCornerShape(15.dp))
            .padding(horizontal = 10.dp, vertical = 2.dp)
    )
}


@Composable
fun ClickableSample() {
    val count = remember { mutableStateOf(0) }
    Text(
        text = count.value.toString(),
        modifier = Modifier.clickable(indication = null,//移除水波纹
            interactionSource = remember { MutableInteractionSource() }) {
            count.value += 1
        },
    )
}

@Composable
fun GithubCommonListItem(
    avatarUrl: String,
    userName: String,
    score: String,
    html: String,
    userId: Int,
    onFollowButtonText: String? = null,
    onItemClick: ((Int) -> Unit)? = null,
    onFollowButtonClick: ((Int) -> Unit)? = null,
    isShowButton: Boolean = false
) {
    Box(modifier = Modifier
        .fillMaxWidth()
        .background(Color.White)
        .height(64.dp)
        .clickable { onItemClick?.invoke(userId) }) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .height(64.dp),
            verticalAlignment = Alignment.CenterVertically

        ) {
            AsyncImage(
                model = avatarUrl,
                contentDescription = null,
                modifier = Modifier
                    .padding(end = 8.dp)
                    .size(32.dp)
                    .clip(CircleShape)
            )
            ConstraintLayout(modifier = Modifier.weight(1f)) {
                val (text1, text2, text3) = createRefs()
                createHorizontalChain(text1, text2, chainStyle = ChainStyle.Packed(0f))
                Text(text = userName,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    modifier = Modifier
                        .padding(end = 6.dp)
                        .constrainAs(text1) {
                            start.linkTo(parent.start)
                            end.linkTo(text2.start)
                            top.linkTo(parent.top)
                            bottom.linkTo(text3.top)

                            width = Dimension.preferredWrapContent
                        })
                Text(text = score, modifier = Modifier
                    .padding(end = 6.dp)
                    .constrainAs(text2) {
                        start.linkTo(text1.end)
                        end.linkTo(parent.end)
                        top.linkTo(parent.top)
                        bottom.linkTo(parent.bottom)
                        height = Dimension.ratio("0")
                    }, color = Color(0xFF6D6D6D)
                )
                Text(maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    text = html,
                    color = Color(0xFF6D6D6D),
                    modifier = Modifier.constrainAs(text3) {
                        start.linkTo(text1.start)
                        end.linkTo(parent.end)
                        top.linkTo(text1.bottom)
                        bottom.linkTo(parent.bottom)
                        width = Dimension.ratio("0")
                    })
            }
            if (isShowButton) {
                Button(
                    contentPadding = PaddingValues(0.dp),
                    onClick = {
                        onFollowButtonClick?.invoke(userId)
                    },
                    colors = ButtonDefaults.buttonColors(backgroundColor = Color.Black),
                    modifier = Modifier
                        .padding(0.dp)
                        .height(24.dp)
                        .width(55.dp)
                ) {
                    Text(
                        text = onFollowButtonText ?: "",
                        fontSize = 10.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color.White
                    )
                }
            }

        }
        Divider(
            modifier = Modifier
                .fillMaxWidth()
                .height(1.dp)
                .background(Color(0xFFEFEFEF))
                .align(Alignment.BottomCenter)
        )
    }
}
