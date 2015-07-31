<?php

  namespace Flox\Http\Controllers;

  use Flox\Item;
  use Flox\Category;
  use Flox\Http\Controllers\Controller;
  use Illuminate\Support\Facades\Request;
  use Illuminate\Support\Str;

  class FloxController extends Controller {

    public function homeItems($category, $orderBy, $loading = 5)
    {
      return $this->getItems($category, $orderBy, $loading);
    }

    public function categoryItems($category, $orderBy, $loading)
    {
      return $this->getItems($category, $orderBy, $loading);
    }

    public function moreCategoryItems($categoryID, $orderBy, $loading, $loaded)
    {
      return Item::where('category_id', $categoryID)->orderBy($orderBy, 'desc')->take($loading)->skip($loaded)->get();
    }

    public function allCategories()
    {
      return Category::all();
    }

    public function slugItem($slug)
    {
      return Item::where('slug', $slug)->first();
    }

    private function getItems($category, $orderBy, $count)
    {
      $category = Category::where('slug', $category)->with('itemsCount')->first();
      $items = Item::where('category_id', $category->id)->orderBy($orderBy, 'desc')->take($count)->get();

      return [
        'items' => $items,
        'category' => $category
      ];
    }

    public function searchFloxByTitle($title)
    {
      // todo: Implement Levenshtein ;)
      return Item::where('title', 'LIKE', '%' . $title . '%')->with('categories')->get();
    }

    public function newItem()
    {
      $item = new Item();

      $item->tmdb_id = Request::input('data.tmdb_id');
      $item->title = Request::input('data.title');
      $item->slug = Str::slug(Request::input('data.title'));
      $item->poster = Request::input('data.poster');
      $item->category_id = 1;
      $item->rating = 2;
      $item->released = Request::input('data.released');
      $item->seen = time();
      $item->created_at = time();
      $item->save();
    }
  }