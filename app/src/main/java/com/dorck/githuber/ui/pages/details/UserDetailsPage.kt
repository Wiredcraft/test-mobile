@file:OptIn(
    ExperimentalFoundationApi::class, ExperimentalFoundationApi::class,
    ExperimentalFoundationApi::class, ExperimentalGlideComposeApi::class
)

package com.dorck.githuber.ui.pages.details

import android.annotation.SuppressLint
import androidx.activity.compose.BackHandler
import androidx.compose.animation.animateContentSize
import androidx.compose.animation.core.LinearOutSlowInEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Divider
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.constraintlayout.compose.ChainStyle
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.constraintlayout.compose.Dimension
import androidx.hilt.navigation.compose.hiltViewModel
import com.bumptech.glide.integration.compose.ExperimentalGlideComposeApi
import com.bumptech.glide.integration.compose.GlideImage
import com.dorck.githuber.R
import com.dorck.githuber.ui.components.*
import com.dorck.githuber.ui.wrapper.RepoDisplayBean
import com.dorck.githuber.ui.wrapper.RepoDisplayUIState
import com.dorck.githuber.ui.wrapper.UserDisplayBean
import com.google.accompanist.insets.ProvideWindowInsets
import com.google.accompanist.systemuicontroller.rememberSystemUiController

val headerBgColor = Color(0XFF1A1A1A)

@SuppressLint("CoroutineCreationDuringComposition")
@Composable
fun UserDetails(
    viewModel: UserDetailsViewModel = hiltViewModel(),
    id: String = "",
    onBack: ((String, Boolean) -> Unit)? = null
) {
    val reposUiState: RepoDisplayUIState by viewModel.reposUIState.collectAsState()
    val ownerInfo: UserDisplayBean? by viewModel.owner.collectAsState()
    LaunchedEffect(id) {
        viewModel.fetchRepos()
    }

    BackHandler(true) {
        viewModel.resetPage()
        onBack?.invoke(ownerInfo?.id ?: "", ownerInfo?.following ?: false)
    }
    ProvideWindowInsets {
        val systemUiController = rememberSystemUiController()
        SideEffect {
            systemUiController.setStatusBarColor(headerBgColor, darkIcons = false)
        }
        Column(
            Modifier
                .fillMaxSize()
                .background(Color.White)) {
            UserHeader(userDisplayBean = ownerInfo!!) {
                viewModel.startFollow()
            }
            Spacer(modifier = Modifier.height(10.dp))
            CategorySection()
            Spacer(modifier = Modifier.height(12.dp))
            RepoListContent(Modifier, repoList = reposUiState.repoList) {
                // TODO: Finish load more logic.
                //viewModel.fetchRepos()
            }
        }
    }
}

@Composable
fun UserHeader(userDisplayBean: UserDisplayBean, onFollowClick: ((String) -> Unit)? = null) {
    Box(
        Modifier
            .fillMaxWidth()
            .height(186.dp),
        contentAlignment = Alignment.Center
    ) {
        Image(
            painter = painterResource(id = R.drawable.header_bg),
            contentDescription = stringResource(id = R.string.header_image_content_desc),
            modifier = Modifier.fillMaxSize(),
            contentScale = ContentScale.FillBounds
        )
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Spacer(Modifier.height(12.dp))
            GlideImage(
                model = userDisplayBean.avatar,
                modifier = Modifier
                    .size(64.dp)
                    .clip(CircleShape),
                contentDescription = stringResource(R.string.avatar_content_desc),
                contentScale = ContentScale.Crop
            )
            Spacer(Modifier.height(16.dp))
            Text(
                userDisplayBean.username,
                modifier = Modifier
                    .padding(horizontal = 12.dp)
                    .wrapContentSize(),
                color = Color.White,
                fontSize = 16.sp,
                maxLines = 1,
                textAlign = TextAlign.Center
            )
            Spacer(Modifier.height(10.dp))
            CommonButton(
                text = if (userDisplayBean.following) "取消关注" else "关注",
                bgColor = ButtonDefaults.buttonColors(backgroundColor = Color.White),
                textColor = Color.Black,
                onClick = {
                    onFollowClick?.invoke(userDisplayBean.id)
                }
            )
        }
    }

}

@Composable
fun RepoListContent(
    modifier: Modifier = Modifier,
    repoList: List<RepoDisplayBean>,
    onLoadMore: (() -> Unit)? = null
) {
    val lazyRepoListState = rememberLazyListState()
    Box(modifier = modifier) {
        LazyColumn(
            modifier = modifier
                .fillMaxWidth(),
            state = lazyRepoListState
        ) {
            items(items = repoList, key = { it.id }) { repo ->
                GithubRepoListItem(
                    Modifier.animateItemPlacement(
                        animationSpec = tween(
                            durationMillis = 500,
                            easing = LinearOutSlowInEasing,
                        )
                    ),
                    repoData = repo,
                )
            }
        }
        // Load more handler.
        LoadMoreHandler(listState = lazyRepoListState) {
            onLoadMore?.invoke()
        }
    }
}

@Composable
fun GithubRepoListItem(
    modifier: Modifier = Modifier,
    repoData: RepoDisplayBean,
    onItemClick: (() -> Unit)? = null,
) {
    ConstraintLayout(
        modifier = modifier
            .fillMaxWidth()
            .animateContentSize()
            .background(Color.White)
            .clickable(onClick = {})
    ) {
        val (avatar, name, score, link, divider) = createRefs()

        GlideImage(
            modifier = Modifier
                .size(32.dp)
                .clip(CircleShape)
                .constrainAs(avatar) {
                    start.linkTo(parent.start, 20.dp)
                    centerVerticallyTo(parent)
                },
            model = repoData.ownerAvatar,
            contentDescription = stringResource(R.string.avatar_content_desc),
            contentScale = ContentScale.Crop,
        )
        // Create a chain between `name` and `score` text.
        createHorizontalChain(name, score, chainStyle = ChainStyle.Packed(0f))
        Text(
            repoData.repoName,
            modifier = Modifier.constrainAs(name) {
                linkTo(
                    start = avatar.end,
                    end = score.start,
                    startMargin = 10.dp,
                    // Keep offset at start
                    bias = 0f
                )
                top.linkTo(parent.top, 16.dp)
                width = Dimension.preferredWrapContent
            },
            color = Color.Black,
            fontSize = 14.sp,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis
        )
        Text(
            repoData.stargazer,
            modifier = Modifier.constrainAs(score) {
                start.linkTo(name.end, 6.dp)
                top.linkTo(parent.top)
                end.linkTo(parent.end, 10.dp)
                centerVerticallyTo(name)
            },
            color = descriptionTextColor,
            fontSize = 12.sp,
            maxLines = 1,
        )
        Text(
            repoData.repoUrl,
            color = descriptionTextColor,
            fontSize = 12.sp,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.constrainAs(link) {
                linkTo(
                    start = avatar.end,
                    end = parent.end,
                    top = name.bottom,
                    bottom = parent.bottom,
                    startMargin = 10.dp,
                    endMargin = 10.dp,
                    bottomMargin = 16.dp,
                    horizontalBias = 0f
                )
                width = Dimension.fillToConstraints
            }
        )

        // Place bottom divider
        Divider(
            Modifier
                .constrainAs(divider) {
                    bottom.linkTo(parent.bottom)
                    width = Dimension.fillToConstraints
                }
                .padding(horizontal = 20.dp),
            color = dividerColor
        )
    }
}

@Composable
fun CategorySection() {
    Row(
        Modifier
            .fillMaxWidth()
            .wrapContentHeight()
            .background(Color.White), verticalAlignment = Alignment.CenterVertically
    ) {
        Spacer(Modifier.width(18.dp))
        Divider(
            Modifier
                .height(20.dp)
                .width(2.dp), color = headerBgColor
        )
        Spacer(Modifier.width(10.dp))
        Text(
            "REPOSITORIES",
            color = Color(0XFF1A1A1A),
            fontSize = 16.sp,
        )
    }
}

@Preview
@Composable
fun PreviewHeader() {
    UserHeader(userDisplayBean = defaultUserData)
}

@Preview
@Composable
fun PreviewUserDetailsPage() {
    UserDetails()
}